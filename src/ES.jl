
	
	
 module ES

	using HTTP
	using JSON
	export Esinfo, escount, esearch ,escroll, @esexp ,@esexport ,escrollclear,esupdate,escript

	struct Esinfo
		host::AbstractString
		port::AbstractString
	end

	struct ActionType{T} end

	function makeurl(::Type{ActionType{:_count}}, info::Esinfo, index::AbstractString)
		"http://$(info.host):$(info.port)/$index/_count"
	end

	function makeurl(::Type{ActionType{:_search}}, info::Esinfo, index::AbstractString, path::AbstractString)
		"http://$(info.host):$(info.port)/$index/$path"
	end

	function makeurl(::Type{ActionType{:_scroll}}, info::Esinfo )
		"http://$(info.host):$(info.port)/_search/scroll"
	end

	function makeurl(::Type{ActionType{:_update}}, info::Esinfo )
		"http://$(info.host):$(info.port)/_bulk"
	end

	macro esexp(x,y)
		esc(:(get($x, $y, missing)))  
	end

	macro esexport(method, url, body , query , type )
	
		header = ["content-type" => "application/$type" ]
		esc(
			quote
				
				respos = HTTP.request($method, $url , $header , $body, query= $query)

				if respos.status == 200
					 JSON.parse(String(respos.body))
				end

			end )
	end

	function escount(info::Esinfo, index::AbstractString)

		url = makeurl(ActionType{:_count}, info, index )
		res = @esexport "GET" url Dict() Dict() "json"
		@esexp res "count"

	end

	function esearch(info::Esinfo, index::AbstractString, body::Dict , path::AbstractString="_search" ; kw...)

		query = Dict(kw...)
		url   = makeurl(ActionType{:_search}, info, index , path )
		@esexport "POST" url json(body) query "json"

	end

	function escroll(info::Esinfo, id::AbstractString, scroll::AbstractString="1m")

		body  = Dict("scroll" => scroll, "scroll_id" => id)
		url   = makeurl(ActionType{:_scroll}, info )
		@esexport "POST" url json(body) Dict() "json"

	end

	function escrollclear(info::Esinfo, id::Union{Vector{AbstractString},AbstractString} )

		url   = makeurl(ActionType{:scroll}, info )
		body = Dict("scroll_id" => id)
		@esexport "DELETE" url json(body) Dict() "json"

	end

	function escrollclear(info::Esinfo)

		url   = makeurl(ActionType{:scroll}, info )
		body  = Dict()
		@esexport "DELETE" (url * "/_all") json(body) Dict() "json"

	end

	function esupdate(info::Esinfo, index::AbstractString, doctype::AbstractString, 
						data::Vector{<:Dict{<:AbstractString}}, 
						id::Vector{<:Union{Number,AbstractString}},
						asupsert::Bool)

		if length(data) != length(id)
			throw("id size != data size")
		end 
		
		chunk = (makebulk(ActionType{:_update}, index, doctype, x, y , asupsert) for (x ,y) in zip(data, id) )
		esupdate(info, chunk)

	end 

	function escript(info::Esinfo, index::AbstractString, doctype::AbstractString, 
						data::Vector{<:Dict{<:AbstractString}}, 
						id::Vector{<:Union{Number,AbstractString}},
						 sid::AbstractString,asupsert::Bool)

		if length(data) != length(id)
			throw("id size != data size")
		end
		
		chunk = (makebulk(ActionType{:script}, index, doctype, x, y , sid, asupsert) for (x ,y) in zip(data, id) )
		esupdate(info, chunk)
	 

	end 
	
 	function makebulk(::Type{ActionType{:_update}}, index::AbstractString, doctype::AbstractString, 
						data::Dict{<:AbstractString}, id::Union{AbstractString, Number}, asupsert::Bool)

			title = Dict("update" => Dict("_index" => index, "_type" => doctype, "_id" =>id ) ) |> json
			content = Dict("doc" => data, "doc_as_upsert" => asupsert) |> json
			return( "$(title)\n$(content)\n")
	 
	end 
	
	function makebulk(::Type{ActionType{:script}}, index::AbstractString, doctype::AbstractString, 
						data::Dict{<:AbstractString}, id::Union{AbstractString, Number},
						sid::AbstractString,asupsert::Bool)
		
			title = Dict("update" => Dict("_index" => index, "_type" => doctype, "_id" =>id ) ) |> json
			content = Dict("script" => Dict("id" => sid, "params" => Dict("event" => data)), 
											"doc_as_upsert" => asupsert, "lang" => "") |> json
			return("$(title)\n$(content)\n")
		
	end 

	function esupdate(info::Esinfo, data)
		url   = makeurl(ActionType{:_update}, info )
		query = Dict( )
		@esexport "POST" url data query "x-ndjson"
	end 

end
