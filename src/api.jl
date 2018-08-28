
	struct Esinfo
		host::AbstractString
		port::AbstractString
	end

	struct ActionType{T} end
	struct BulkType{T} end

	struct BulkLength{T<:Number}
           seq::T
           count::T
    end 

    Base.iterate(B::BulkLength, state=0) = state  >= B.count ? nothing : ( ( state+1, ( state+B.seq) > B.count ? B.count : (state + B.seq) ) , state+B.seq )

	function makeurl(::Type{ActionType{:_count}}, info::Esinfo, index::AbstractString)
		"http://$(info.host):$(info.port)/$index/_count"
	end

	function makeurl(::Type{ActionType{:_search}}, info::Esinfo, index::AbstractString, path::AbstractString)
		"http://$(info.host):$(info.port)/$index/$path"
	end

	function makeurl(::Type{ActionType{:_scroll}}, info::Esinfo )
		"http://$(info.host):$(info.port)/_search/scroll"
	end

	function makeurl(::Type{ActionType{:_bulk}}, info::Esinfo, index::AbstractString, doc::AbstractString)
		"http://$(info.host):$(info.port)/$index/$doc/_bulk"
	end

	function makeurl(::Type{ActionType{:_bulk}}, info::Esinfo)
		"http://$(info.host):$(info.port)/_bulk"
	end

	macro esexp(x,y)
		esc(:(get($x, $y, missing)))  
	end

	macro esexport(method, url, body , query , type )
	
		header = ["content-type" => "$type" ]
		esc(
			quote
				
				respos = HTTP.request($method, $url , $header , $body, query= $query)

				if respos.status == 200
					 JSON.parse(String(respos.body))
				end

			end )
	end



	function filtercombin(; filters...)
		esfilter = Dict(filters...)
		Dict("bool" => Dict("filter" => esfilter ))
	end 

	function aggscombin(aggs::Vector{<:Dict})
		map(reduce, aggs)
	end 

	function escount(info::Esinfo, index::AbstractString)

		url   = makeurl(ActionType{:_count}, info, index )
		res   = @esexport "GET" url Dict() Dict() "application/json"
		@esexp res "count"

	end

	function escount(info::Esinfo, index::AbstractString, body::Dict{<:AbstractString})

		url   = makeurl(ActionType{:_count}, info, index )
		res   = @esexport "POST" url json(body) Dict() "application/json"
		@esexp res "count"

	end

	function escount(info::Esinfo, index::AbstractString, body::AbstractString)

		url   = makeurl(ActionType{:_count}, info, index )
		res   = @esexport "POST" url body Dict() "application/json"
		@esexp res "count"

	end
	
	function esearch(info::Esinfo, index::AbstractString, body::AbstractString , path::AbstractString="_search" ; kw...)

		query = Dict(kw...)
		url   = makeurl(ActionType{:_search}, info, index , path )
		@esexport "POST" url body query "application/json"

	end
	
	function esearch(info::Esinfo, index::AbstractString, body::Dict , path::AbstractString="_search" ; kw...)

		query = Dict(kw...)
		url   = makeurl(ActionType{:_search}, info, index , path )
		@esexport "POST" url json(body) query "application/json"
		
	end

	function escroll(info::Esinfo, id::AbstractString, scroll::AbstractString="1m")

		body  = Dict("scroll" => scroll, "scroll_id" => id)
		url   = makeurl(ActionType{:_scroll}, info )
		@esexport "POST" url json(body) Dict() "application/json"

	end

	function escrollclear(info::Esinfo, id::Union{Vector{AbstractString},AbstractString} )

		url   = makeurl(ActionType{:scroll}, info )
		body = Dict("scroll_id" => id)
		@esexport "DELETE" url json(body) Dict() "application/json"

	end

	function escrollclear(info::Esinfo)

		url   = makeurl(ActionType{:scroll}, info )
		body  = Dict()
		@esexport "DELETE" (url * "/_all") json(body) Dict() "application/json"

	end
	
	macro esdatawarn(x, y)
		esc(:(length($x) != length($y) && throw("id size != data size")))
	end 
 
	function esbulkupdate(info::Esinfo, index::AbstractString, doc::AbstractString, 
						data::Vector{<:Dict{<:AbstractString}}, 
						id::Vector{<:Union{Number,AbstractString}}, 
						asupsert::Bool=true  ,chunk_num::Number=1000 ; kw...)

		@esdatawarn data id 

		for (m, n) in BulkLength( chunk_num, length(id) )
			chunk = (makebulk(BulkType{:_update},  x, y , asupsert) for (x ,y) in zip(data[m:n], id[m:n]) )
		   	esbulk(info, index, doc, chunk, kw...)
		end 

	end 	

	function esbulkcript(info::Esinfo, index::AbstractString, doc::AbstractString, 
						data::Vector{<:Dict{<:AbstractString}}, 
						id::Vector{<:Union{Number,AbstractString}},
						  sid::AbstractString,asupsert::Bool=true,chunk_num::Number=1000 ; kw... )

		@esdatawarn data id 
		for (m, n) in BulkLength( chunk_num, length(id) )
			chunk = (makebulk(BulkType{:_script},  x, y , sid, asupsert) for (x ,y) in zip(data[m:n], id[m:n]) )
			esbulk(info, index, doc, chunk, kw...)
		end  

	end 
	
	function esbulkindex(info::Esinfo, index::AbstractString, doc::AbstractString, 
						data::Vector{<:Dict{<:AbstractString}}, 
						id::Vector{<:Union{Number,AbstractString}} ,chunk_num::Number=1000 ; kw... )

		@esdatawarn data id 
		for (m, n) in BulkLength( chunk_num, length(id) )
			chunk = (makebulk(BulkType{:_index}, x, y  ) for (x ,y) in zip(data[m:n], id[m:n]) )
			esbulk(info, index, doc, chunk, kw...)
		end 
	 
	end 
	
	function esbulkcreate(info::Esinfo, index::AbstractString, doc::AbstractString, 
						data::Vector{<:Dict{<:AbstractString}}, 
						id::Vector{<:Union{Number,AbstractString}},chunk_num::Number=1000 ; kw...)

		@esdatawarn data id 
		for (m, n) in BulkLength( chunk_num, length(id) )
			chunk = (makebulk(BulkType{:_create},  x, y ) for (x ,y) in zip(data[m:n], id[m:n]) )
			esbulk(info, index, doc, chunk, kw...)
		end 
	 
	end 
	
	function esbulkdel(info::Esinfo, index::AbstractString, doc::AbstractString, 
						data::Vector{<:Dict{<:AbstractString}}, 
						id::Vector{<:Union{Number,AbstractString}},chunk_num::Number=1000 ; kw... )

		for (m, n) in BulkLength( chunk_num, length(id) )
			chunk = (makebulk(BulkType{:_del}, x ) for x in id[m:n] )
			esbulk(info, index, doc, chunk, kw...)
	 	end 

	end
	
	macro esmeta(method, id)
		esc(:(json(Dict($method => Dict( "_id" => $id )) )))
	end 
	
	function makebulk(::Type{BulkType{:_del}}, id::Union{AbstractString, Number} )

		title =  @esmeta "delete" id 
		return( "$(title)\n")
	 
	end 
	
 	function makebulk(::Type{BulkType{:_index}},  data::Dict{<:AbstractString}, 
 						id::Union{AbstractString, Number} )

		title =  @esmeta "index" id 
		content = data |> json
		return( "$(title)\n$(content)\n")
	 
	end 
	
	 function makebulk(::Type{BulkType{:_create}},  data::Dict{<:AbstractString}, 
	 					id::Union{AbstractString, Number})

		title =  @esmeta "create" id 
		content = data |> json
		return( "$(title)\n$(content)\n")
	 
	end 
	
 	function makebulk(::Type{BulkType{:_update}},  data::Dict{<:AbstractString}, 
 						id::Union{AbstractString, Number} ,asupsert::Bool)

		title =  @esmeta "update"  id 
		content = Dict("doc" => data, "doc_as_upsert" => asupsert) |> json
		return( "$(title)\n$(content)\n")
	 
	end 
	
	function makebulk(::Type{BulkType{:_script}},  data::Dict{<:AbstractString}, id::Union{AbstractString, Number} ,
						sid::AbstractString,asupsert::Bool)
		
		title =  @esmeta "update" id 
		content = Dict("script" => Dict("id" => sid, "params" => Dict("event" => data)), 
										"doc_as_upsert" => asupsert, "lang" => "") |> json
		return("$(title)\n$(content)\n")
		
	end 

	function esbulk(info::Esinfo , index::AbstractString, doc::AbstractString , data ; kw...)
		url   = makeurl(ActionType{:_bulk}, info ,index, doc )
		query = Dict(kw...)
		@esexport "POST" url data query "application/x-ndjson"
	end 

	function esbulk(info::Esinfo , data  ; kw...)
		url   = makeurl(ActionType{:_bulk}, info  )
		query = Dict(kw...)
		@esexport "POST" url data query "application/x-ndjson"
	end 

 
