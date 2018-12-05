
struct CatType{T} end

function make_url(::Type{CatType{:_cat}}, info::Esinfo, paths::AbstractString, name::AbstractString)
	"http://$(info.host):$(info.port)/_cat/$paths/$name"
end

function make_url(::Type{CatType{:_cat}}, info::Esinfo,paths::AbstractString)
	"http://$(info.host):$(info.port)/_cat/$paths"
end

macro catgenfun(methods, paths, names )
	funname = esc(Symbol(string("cat_", paths )) )
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
				url    = make_url(CatType{:_cat}, info, $paths, name)
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
				url    = make_url(CatType{:_cat}, info, $paths)
				@catexport $methods  url  querys 
			end )
	) 
end 

##
@catgenfun "GET" "aliases"  "name"
@catgenfun "GET" "aliases"
@catgenfun "GET" "fielddata" "fields"
@catgenfun "GET" "fielddata"
@catgenfun "GET" "allocation"  "node_id"
@catgenfun "GET" "allocation"
@catgenfun "GET" "count"  "index"
@catgenfun "GET" "count"
@catgenfun "GET" "health"
@catgenfun "GET" "master" 
@catgenfun "GET" "nodeattrs"
@catgenfun "GET" "pending_tasks" 
@catgenfun "GET" "plugins" 
@catgenfun "GET" "recovery"  "index" 
@catgenfun "GET" "recovery"
@catgenfun "GET" "repositories" 
@catgenfun "GET" "segments"  "index" 
@catgenfun "GET" "segments"
@catgenfun "GET" "shards"  "index" 
@catgenfun "GET" "shards"
@catgenfun "GET" "snapshots"  "repository" 
@catgenfun "GET" "snapshots"
@catgenfun "GET" "tasks" 
@catgenfun "GET" "templates"  "name" 
@catgenfun "GET" "templates"
@catgenfun "GET" "thread_pool"  "thread_pool_patterns" 
@catgenfun "GET" "thread_pool"


