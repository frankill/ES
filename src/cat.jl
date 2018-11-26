
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

macro catgenfun(methods, paths, names )
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


@catgenfun "GET" "aliases"  "name"
@catgenfun "GET" "fielddata" "fields"
@catgenfun "GET" "allocation"  "node_id"
@catgenfun "GET" "count"  "index"
@catgenfun "GET" "health"  nothing
@catgenfun "GET" "master"  nothing 
@catgenfun "GET" "nodeattrs"  nothing
@catgenfun "GET" "pending_tasks"  nothing 
@catgenfun "GET" "plugins"  nothing 
@catgenfun "GET" "recovery"  "index" 
@catgenfun "GET" "repositories"  nothing 
@catgenfun "GET" "segments"  "index" 
@catgenfun "GET" "shards"  "index" 
@catgenfun "GET" "snapshots"  "repository" 
@catgenfun "GET" "tasks"  nothing 
@catgenfun "GET" "templates"  "name" 
@catgenfun "GET" "thread_pool"  "thread_pool_patterns" 
