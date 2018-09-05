struct SearchNode{T} end

const  sname = ["filter", "must", "must_not", "query" , "nested", "has_child" ,"has_parent"]

function Base.push!(t::AbstractDict, b::AbstractDict)
	for (x,y) in b 
		push!(t, x => y)
	end 
end  

function make_json(method::AbstractString, exprs::Vector )
	esc(quote
			local len = length($exprs)
			local val = Array{Dict}(undef, length($exprs))
			
			for i in 1:len
				(methods, name, content)  = estrans($exprs[i])
				name == nothing && ((methods, name, content) = eval(content))
				if string(name) in sname  
					val[i] =  eval(content) 
				else 
					val[i] = Dict(methods => Dict(name =>  eval(content)   )) 
				end 
			end 
			
			Dict($method => val)
	end)
end

function make_json(  exprs::Vector, type::AbstractString )
	esc(quote
			local len = length($exprs)
			local val = Dict()
			
			for i in 1:len
				(methods, name, content)  = estrans($exprs[i])
				name == nothing && ((methods, name, content) = eval(content))
				if string(name) in sname  
					push!(val, eval(content ))
				else 
					push!(val, name => eval(content )) 
				end 
			end 
			
			Dict($type => val)
	end)	
end

function make_json( exprs::Vector )
	esc(quote
			local len = length($exprs)
			local val = Dict()
			local query = Dict()
			
			for i in 1:len
				(methods, name, content)  = estrans($exprs[i])
				name == nothing && ((methods, name, content) = eval(content))
				if string(name) in sname  
					push!(query, eval(content ))
				else 
					push!(val, name => eval(content )) 
				end 
			end 
			
			if ! isempty(query)
				merge(val,  Dict("query" => Dict( "bool" => query)))
			else 
				val
			end 
	end)
end
 
macro fulltext( expr... )
    return  make_json(collect( expr ) ,"query") 
end

macro filter( expr... )
    return  make_json( "filter", collect( expr ))
end

macro must( expr... )
    return make_json( "must", collect( expr )) 
end

macro must_not( expr... )
    return  make_json( "must_not", collect( expr )) 
end

macro query( expr... )
    return  make_json( collect( expr )) 
end

macro nested( expr... )
    return  make_json(collect( expr ) ,"nested") 
end

macro has_child( expr... )
    return  make_json(collect( expr ) ,"has_child") 
end

macro has_parent( expr... )
    return  make_json(collect( expr ) ,"has_parent") 
end

function estrans( expr::Expr )
    estrans( SearchNode{expr.head}, expr)
end

function estrans(expr::Symbol)
    (nothing  , nothing ,  Expr(:call, :estrans, expr) )
end

function estrans( ::Type{SearchNode{:call}}, expr::Expr)
     estrans(SearchNode{expr.args[1]}, expr)
end

function estrans(::Type{SearchNode{:(=)}}, expr::Expr)
	("term" , expr.args[1] ,  expr.args[2] )
end 

function estrans(::Type{SearchNode{:(in)}}, expr::Expr)
	("terms" , expr.args[2] , expr.args[3] )
end 

function estrans(::Type{SearchNode{:(has)}}, expr::Expr)
	("exists" , "field" , expr.args[2] )
end 

function estrans(::Type{SearchNode{:(>=)}}, expr::Expr)
	("range" , expr.args[2] , :(Dict( "gte" => $(expr.args[3])) ))
end 

function estrans(::Type{SearchNode{:(<=)}}, expr::Expr)
	("range" , expr.args[2] , :(Dict( "lte" => $(expr.args[3])) ))
end 

function estrans(::Type{SearchNode{:(>)}}, expr::Expr)
	("range" , expr.args[2] , :(Dict( "gt" => $(expr.args[3])) ))
end 

function estrans(::Type{SearchNode{:(<)}}, expr::Expr)
	("range" , expr.args[2] , :(Dict( "lt" => $(expr.args[3])) ))
end 

function estrans(::Type{SearchNode{:comparison}}, expr::Expr)
	sym = ( syms(esyms{expr.args[2]}) ,syms( ! esyms{expr.args[4]}) )
	("range" , expr.args[3] , :(Dict( $(sym[1]) => $(expr.args[1]) ,$(sym[2]) => $(expr.args[5]) )))
end 

abstract type esyms{T} end 

syms(::Type{esyms{:<}})    = "gt"
syms(::Type{esyms{:(<=)}})   = "gte"
syms(::Type{esyms{:>}})    = "lt"
syms(::Type{esyms{:(>=)}})   = "lte" 

Base.:!(::Type{esyms{:<}})  = esyms{:>}
Base.:!(::Type{esyms{:(<=)}}) = esyms{:(>=)}
Base.:!(::Type{esyms{:>}})  = esyms{:<}
Base.:!(::Type{esyms{:(<=)}})  = esyms{:(>=)}

function estrans(::Type{SearchNode{:macrocall}}, expr::Expr)
	(nothing  , replace(string(expr.args[1]), "@" => "")  , expr)
end 

