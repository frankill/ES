
struct Esinfo
	host::AbstractString
	port::AbstractString
end

Esinfo(host::AbstractString) = Esinfo(host, "9200")

struct ActionType{T} end
struct BulkType{T} end

struct BulkLength{T<:Number}
   seq::T
   count::T
end 

const EsData = Union{NamedTuple,Dict}
const EsId   = Union{Number,AbstractString}

escape(x) = esc(x) 
escape(x::AbstractString) = x

macro extra(data, kw...)

	q , len = quote end , length(kw)
	q = Expr(:ref, esc(data) , escape(kw[1]))
	len == 1 && return q 

	for i in 2:len 
		q = Expr(:ref , q , escape(kw[i]))
	end 

	return q 

end

Base.iterate(B::BulkLength, state=0) = state  >= B.count ? nothing : ( ( state+1, ( state+B.seq) > B.count ? B.count : (state + B.seq) ) , state+B.seq )
Base.length(B::BulkLength)           = Int(ceil(B.count/B.seq))

function make_url(::Type{ActionType{:_count}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_count"
end

function make_url(::Type{ActionType{:_search}}, info::Esinfo, index::AbstractString, path::AbstractString)
	"http://$(info.host):$(info.port)/$index/$path"
end

function make_url(::Type{ActionType{:_scroll}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_search/scroll"
end

function make_url(::Type{ActionType{:_bulk}}, info::Esinfo, index::AbstractString, doc::AbstractString)
	"http://$(info.host):$(info.port)/$index/$doc/_bulk"
end

function make_url(::Type{ActionType{:_bulk}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_bulk"
end

macro esexp(x,y)
	esc(:(get($x, $y, missing)))  
end

macro esexport(method, url, body , query , type )

	header = ["content-type" => "$type" ]
	esc(
		quote

			respos = HTTP.request($method, HTTP.URI($(url)) , $header , $body, query= $query)
			
			if respos.status == 200 
				JSON.parse(String(respos.body))
			end

		end )
end

function es_count(info::Esinfo, index::AbstractString ; kw...)

	url   = make_url(ActionType{:_count}, info, index )
	res   = @esexport "GET" url Dict() Dict(kw...) "application/json"
	@esexp res "count"

end

function es_count(info::Esinfo, index::AbstractString, body::Dict ; kw...)

	url   = make_url(ActionType{:_count}, info, index )
	res   = @esexport "POST" url json(body) Dict(kw...) "application/json"
	@esexp res "count"

end

function es_count(info::Esinfo, index::AbstractString, body::AbstractString ; kw...)

	url   = make_url(ActionType{:_count}, info, index )
	res   = @esexport "POST" url body Dict(kw...) "application/json"
	@esexp res "count"

end

function es_search(info::Esinfo, index::AbstractString, body::AbstractString , path::AbstractString="_search" ; kw...)

	query = Dict(kw...)
	url   = make_url(ActionType{:_search}, info, index , path )
	@esexport "POST" url body query "application/json"

end

function es_search(info::Esinfo, index::AbstractString, body::Dict , path::AbstractString="_search" ; kw...)

	query = Dict(kw...)
	url   = make_url(ActionType{:_search}, info, index , path )
	@esexport "POST" url json(body) query "application/json"

end

function es_search(info::Esinfo, index::AbstractString, body::Dict ,query::Dict, path::AbstractString="_search" )

	url   = make_url(ActionType{:_search}, info, index , path )
	@esexport "POST" url json(body) query "application/json"

end

function es_searchs(info::Esinfo, index::AbstractString, body::T ; kw... ) where T <: Union{AbstractString, Dict}

	isa(body , AbstractString) && (body= JSON.Parser.parse(body))

	num   = pop!(body, "size", 10000)
	snum  = (haskey(body, "query") ? Dict("query" => body["query"]) : Dict()) |> 
			df -> es_count(info, index, df)
	query = Dict(kw..., :size => num)
				
	res   = es_search(info, index, body, query)  
	snum  <= num && return res
	
	sizehint!(res["hits"]["hits"], snum)
	ids = res["_scroll_id"]
	for _ in 1:(Int(floor(snum/num)))
		tmp = escroll(info , ids , query[:scroll])  
		append!(res["hits"]["hits"], tmp["hits"]["hits"] )
		ids = tmp["_scroll_id"]
	end 
	res
end

function es_scroll(info::Esinfo, id::AbstractString, scroll::AbstractString="1m")

	body  = Dict("scroll" => scroll, "scroll_id" => id)
	url   = make_url(ActionType{:_scroll}, info )
	@esexport "POST" url json(body) Dict() "application/json"

end

function es_scroll_clear(info::Esinfo, id::Union{Vector{AbstractString},AbstractString} )

	url   = make_url(ActionType{:_scroll}, info )
	body = Dict("scroll_id" => id)
	@esexport "DELETE" url json(body) Dict() "application/json"

end

function es_scroll_clear(info::Esinfo)

	url   = make_url(ActionType{:_scroll}, info )
	body  = Dict()
	@esexport "DELETE" (url * "/_all") json(body) Dict() "application/json"

end

macro esdatawarn(x, y)
	esc(:(length($x) != length($y) && throw("id size != data size")))
end 

function es_bulk_update(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, 
					id::Vector{<:EsId}, 
					asupsert::Bool=true  ,chunk_num::Number=1000 ; kw...)

	@esdatawarn data id 

	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_update},  x, y , asupsert) for (x ,y) in zip(data[m:n], id[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end 	

function es_bulk_update(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, 
					id::Vector{<:EsId}, 
					routing::Vector{<:EsId},
					asupsert::Bool=true  ,chunk_num::Number=1000 ; kw...)

	@esdatawarn data id 

	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_update},  x, y , z, asupsert) for (x ,y,z) in zip(data[m:n], id[m:n],routing[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end 	

function es_bulk_script(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, id::Vector{<:EsId},
					  sid::AbstractString,asupsert::Bool=true,chunk_num::Number=1000 ; kw... )

	@esdatawarn data id 
	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_script},  x, y , sid, asupsert) for (x ,y) in zip(data[m:n], id[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end  

end 

function es_bulk_script(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, id::Vector{<:EsId},routing::Vector{<:EsId},
					  sid::AbstractString,asupsert::Bool=true,chunk_num::Number=1000 ; kw... )

	@esdatawarn data id 
	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_script},  x, y , z, sid, asupsert) for (x ,y,z) in zip(data[m:n], id[m:n],routing[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end  

end 

function es_bulk_index(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, id::Vector{<:EsId} ,chunk_num::Number=1000 ; kw... )

	@esdatawarn data id 
	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_index}, x, y  ) for (x ,y) in zip(data[m:n], id[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end 

function es_bulk_index(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, id::Vector{<:EsId} ,
					routing::Vector{<:EsId},chunk_num::Number=1000 ; kw... )

	@esdatawarn data id 
	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_index}, x, y ,z ) for (x ,y,z) in zip(data[m:n], id[m:n],routing[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end 

function es_bulk_index(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData} ,::Val{true}, chunk_num::Number=1000 ; kw... )

	for (m, n) in BulkLength( chunk_num, length(data) )
		chunk = (make_bulk(BulkType{:_index}, index, doc ,x ) for x in  data[m:n] ) 
		es_bulk(info, chunk; kw...)
	end 

end 

function es_bulk_index(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData} ,routing::Vector{<:EsId},::Val{true}, 
					chunk_num::Number=1000 ; kw... )

	for (m, n) in BulkLength( chunk_num, length(data) )
		chunk = (make_bulk(BulkType{:_index}, index, doc ,x ,y,Val(true)) for (x,y) in  zip(data[m:n], routing[m:n]) ) 
		es_bulk(info, chunk; kw...)
	end 

end 

function es_bulk_create(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, id::Vector{<:EsId},chunk_num::Number=1000 ; kw...)

	@esdatawarn data id 
	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_create},  x, y ) for (x ,y) in zip(data[m:n], id[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end 

function es_bulk_create(info::Esinfo, index::AbstractString, doc::AbstractString, 
					data::Vector{<:EsData}, id::Vector{<:EsId},
					routing::Vector{<:EsId},chunk_num::Number=1000 ; kw...)

	@esdatawarn data id 
	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_create},  x, y ,z) for (x ,y,z) in zip(data[m:n], id[m:n],routing[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end 

function es_bulk_del(info::Esinfo, index::AbstractString, doc::AbstractString,  
					id::Vector{<:EsId},chunk_num::Number=1000 ; kw... )

	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_del}, x ) for x in id[m:n] )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end

function es_bulk_del(info::Esinfo, index::AbstractString, doc::AbstractString, 
					id::Vector{<:EsId},routing::Vector{<:EsId},chunk_num::Number=1000 ; kw... )

	for (m, n) in BulkLength( chunk_num, length(id) )
		chunk = (make_bulk(BulkType{:_del}, x ,y) for (x ,y) in zip(data[m:n], id[m:n]) )
		es_bulk(info, index, doc, chunk; kw...)
	end 

end

macro esmeta(method, id)
	esc(:(json(Dict($method => Dict( "_id" => $id )) )))
end 

function make_bulk(::Type{BulkType{:_del}}, id::EsId )

	title =  @esmeta "delete" id 
	return( "$(title)\n")

end 

function make_bulk(::Type{BulkType{:_del}}, id::EsId,routing::EsId )

	title =  @smi( delete = @smi(_id = id , routing = routing )) |> json
	return( "$(title)\n")

end 

function make_bulk(::Type{BulkType{:_index}},  data::EsData, id::EsId )

	title =  @esmeta "index" id 
	content = data |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_index}},  data::EsData, id::EsId ,routing::EsId)

	title =  @smi( index = @smi(_id = id , routing = routing )) |> json
	content = data |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_index}}, index::AbstractString , type::AbstractString ,
					data::EsData )

	title =  @smi(index = @smi(_index = index , _type = type)) |> json 
	content = data |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_index}}, index::AbstractString , type::AbstractString ,
					data::EsData ,routing::EsId, ::Val{true})

	title =  @smi(index = @smi(_index = index , _type = type,_routing = routing )) |> json 
	content = data |> json
	return( "$(title)\n$(content)\n")

end 

 function make_bulk(::Type{BulkType{:_create}},  data::EsData, id::EsId)

	title =  @esmeta "create" id 
	content = data |> json
	return( "$(title)\n$(content)\n")

end 

 function make_bulk(::Type{BulkType{:_create}},  data::EsData, id::EsId,routing::EsId)

	title =  @smi( create = @smi(_id = id , routing = routing )) |> json
	content = data |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_update}},  data::EsData, id::EsId ,asupsert::Bool)

	title =  @esmeta "update"  id 
	content = Dict("doc" => data, "doc_as_upsert" => asupsert) |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_update}},  data::EsData, id::EsId ,routing::EsId,asupsert::Bool)

	title =  @smi( update = @smi(_id = id , routing = routing )) |> json
	content = Dict("doc" => data, "doc_as_upsert" => asupsert) |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_script}},  data::EsData, id::EsId ,sid::AbstractString,asupsert::Bool)

	title =  @esmeta "update" id 
	content = Dict("script" => Dict("id" => sid, "params" => Dict("event" => data)), 
			"scripted_upsert" => asupsert, "upsert"=> Dict()) |> json
	return("$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_script}},  data::EsData, id::EsId ,routing::EsId ,sid::AbstractString,
														asupsert::Bool)

	title =  @smi( update = @smi(_id = id , routing = routing )) |> json
	content = Dict("script" => Dict("id" => sid, "params" => Dict("event" => data)), 
			"scripted_upsert" => asupsert, "upsert" => Dict()) |> json
	return("$(title)\n$(content)\n")

end 

function es_bulk(info::Esinfo , index::AbstractString, doc::AbstractString , data ; kw...)
	url   = make_url(ActionType{:_bulk}, info ,index, doc )
	query = Dict(kw...)
	@esexport "POST" url data query "application/x-ndjson"
end 

function es_bulk(info::Esinfo , data  ; kw...)
	url   = make_url(ActionType{:_bulk}, info  )
	query = Dict(kw...)
	@esexport "POST" url data query "application/x-ndjson"
end 

# add meta all function 
function es_bulk_update(info::Esinfo,  data::Vector{<:EsData}, asupsert::Bool=true  ,chunk_num::Number=1000 ; kw...)

	for (m, n) in BulkLength( chunk_num, length(data) )
		chunk = (make_bulk(BulkType{:_update}, i , asupsert) for i in data[m:n] )
		es_bulk(info, chunk; kw...)
	end 

end 	

function es_bulk_script(info::Esinfo, data::Vector{<:EsData}, sid::AbstractString,asupsert::Bool=true,
								chunk_num::Number=1000 ; kw... )

	for (m, n) in BulkLength( chunk_num, length(data) )
		chunk = (make_bulk(BulkType{:_script}, i , sid, asupsert) for i in data[m:n] )
		es_bulk(info, chunk; kw...)
	end  

end 

function es_bulk_index( info::Esinfo, data::Vector{<:EsData}, chunk_num::Number=1000 ; kw... )

	for (m, n) in BulkLength( chunk_num, length(data) )
		chunk = (make_bulk(BulkType{:_index}, i ) for i in data[m:n] )
		es_bulk(info, chunk; kw...)
	end 

end 

function es_bulk_create( info::Esinfo, data::Vector{<:EsData}, chunk_num::Number=1000 ; kw...)

	for (m, n) in BulkLength( chunk_num, length(data) )
		chunk = (make_bulk(BulkType{:_create}, i ) for i in data[m:n] )
		es_bulk(info, chunk; kw...)
	end 

end 

function es_bulk_del( info::Esinfo, data::Vector{<:EsData},chunk_num::Number=1000 ; kw... )

	for (m, n) in BulkLength( chunk_num, length(data) )
		chunk = (make_bulk(BulkType{:_del}, i) for i in data[m:n] )
		es_bulk(info, chunk; kw...)
	end 

end


macro esmetaall(method, index, type, id )
	esc(:(json(Dict($method => Dict("_index" => $index, "_type" => $type,  "_id" => $id )) )))
end 

macro esmetaallronting(method, index, type, id, routing )
	esc(:(json(Dict($method => Dict("_index" => $index, "_type" => $type,  "_id" => $id ,"routing" => $routing)) )))
end 

macro flown(x, y ) 
	esc(Expr(:., x, :($(:($y)))))
end 

macro flowd(x, y ) 
	esc(Expr(:ref, x, y ))
end 

ref(x::Dict, y::AbstractString)	=  	@flowd(x,y)
ref(x::NamedTuple, y::Symbol) 	= 	@flown(x,y)
ref(x::Dict, y::Symbol) 	= 	ref(x, String(y))

Base.haskey(nt::Dict, key::Symbol) = Base.haskey(nt, String(key))

macro cheak(method , data) 
	esc(quote
		if haskey($data, :routing)
			title = @esmetaallronting($method,ref($data, :_index),ref($data, :_type),ref($data, :_id),ref($data, :routing))
		else 
			title = @esmetaall($method,ref($data, :_index),ref($data, :_type),ref($data, :_id)) 
		end 
	end)
end 

macro cheak(method , data, yes) 
	esc(quote
		if haskey($data, :routing)
			title = @esmetaallronting($method,ref($data, :_index),ref($data, :_type),ref($data, :_id),ref($data, :routing))
		else 
			if haskey($data, :_id)
				title = @esmetaall($method,ref($data, :_index),ref($data, :_type),ref($data, :_id)) 
			else 
				title = @esmetaall($method,ref($data, :_index),ref($data, :_type) )
			end  
		end 
	end)
end 

function make_bulk(::Type{BulkType{:_del}},  data::EsData )

	@cheak "delete" data 
	return( "$(title)\n")

end

function make_bulk(::Type{BulkType{:_index}}, data::EsData)

	@cheak "index" data 1
	content = ref(data, :_source) |> json
	return( "$(title)\n$(content)\n")

end 

 function make_bulk(::Type{BulkType{:_create}}, data::EsData)
 	@cheak "create" data 
	content = ref(data, :_source) |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_update}}, data::EsData ,asupsert::Bool)
	@cheak "update" data 
	content = Dict("doc" => ref(data, :_source), "doc_as_upsert" => asupsert) |> json
	return( "$(title)\n$(content)\n")

end 

function make_bulk(::Type{BulkType{:_script}}, data::EsData ,sid::AbstractString,asupsert::Bool)
	@cheak "update" data 
	content = Dict("script" => Dict("id" => sid, "params" => Dict("event" => ref(data, :_source))), 
			"scripted_upsert" => asupsert, "upsert" => Dict()) |> json
	return("$(title)\n$(content)\n")

end 
										
