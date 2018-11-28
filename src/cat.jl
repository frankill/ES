
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
	name    = esc(Symbol(names) )

	Expr(:function , 
		Expr(:call , 
			funname ,
			Expr(:parameters, 
				Expr(:(...), :kw)),
			Expr(:(::) , :info , :Esinfo),
			Expr(:(::) , name , :AbstractString)
			) , 
		Expr(:block ,  
			quote
				querys = Dict(kw...) 
				url    = makeurl(CatType{:_cat}, info, $paths, name)
				@catexport $methods  url  querys 
			end )
	) 
end 

macro catgenfun(methods, paths )
	funname = esc(Symbol(string("cat", paths )) )

	Expr(:function , 
		Expr(:call , 
			funname ,
			Expr(:parameters, 
				Expr(:(...), :kw)),
			Expr(:(::) , :info , :Esinfo)
			) , 
		Expr(:block ,  
			quote
				querys = Dict(kw...) 
				url    = makeurl(CatType{:_cat}, info, $paths)
				@catexport $methods  url  querys 
			end )
	) 
end 



@catgenfun "GET" "aliases"  "name"
@catgenfun "GET" "fielddata" "fields"
@catgenfun "GET" "allocation"  "node_id"
@catgenfun "GET" "count"  "index"
@catgenfun "GET" "health"
@catgenfun "GET" "master" 
@catgenfun "GET" "nodeattrs"
@catgenfun "GET" "pending_tasks" 
@catgenfun "GET" "plugins" 
@catgenfun "GET" "recovery"  "index" 
@catgenfun "GET" "repositories" 
@catgenfun "GET" "segments"  "index" 
@catgenfun "GET" "shards"  "index" 
@catgenfun "GET" "snapshots"  "repository" 
@catgenfun "GET" "tasks" 
@catgenfun "GET" "templates"  "name" 
@catgenfun "GET" "thread_pool"  "thread_pool_patterns" 
