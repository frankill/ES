
struct CatType{T} end

function makeurl(::Type{CatType{:_cat}}, info::Esinfo, paths::AbstractString, name::AbstractString)
	"http://$(info.host):$(info.port)/_cat/$paths/$name"
end

function makeurl(::Type{CatType{:_cat}}, info::Esinfo,paths::AbstractString)
	"http://$(info.host):$(info.port)/_cat/$paths"
end

macro catexport(method, url , query  )

	esc(
		quote

			respos = HTTP.request($method, $url, query= $query)
			String(respos.body) |> println

		end )
end

macro genfun(methods, paths, names )
	funname = esc(Symbol(string("cat", paths )) )

	return quote 
		( if $names != nothing 
			
			function $(funname)(info::Esinfo, name::AbstractString ; kw...)  
				querys = Dict(kw...) 
				url    = makeurl(CatType{:_cat}, info, $paths, name)
				@catexport "GET"  url  querys 
			end 
		else 
			nothing 
		end  ,
		function $(funname)(info::Esinfo ;kw...)  
			querys = Dict(kw...) 
			url    = makeurl(CatType{:_cat}, info, $paths)
			@catexport "GET"  url  querys 
		end 
		)
	end
end 


@genfun "GET" "aliases"  "name"
@genfun "GET" "fielddata" "fields"
@genfun "GET" "allocation"  "node_id"
@genfun "GET" "count"  "index"
@genfun "GET" "health"  nothing
@genfun "GET" "master"  nothing 
@genfun "GET" "nodeattrs"  nothing
@genfun "GET" "pending_tasks"  nothing 
@genfun "GET" "plugins"  nothing 
@genfun "GET" "recovery"  "index" 
@genfun "GET" "repositories"  nothing 
@genfun "GET" "segments"  "index" 
@genfun "GET" "shards"  "index" 
@genfun "GET" "snapshots"  "repository" 
@genfun "GET" "tasks"  nothing 
@genfun "GET" "templates"  "name" 
@genfun "GET" "thread_pool"  "thread_pool_patterns" 
