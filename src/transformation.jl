struct SearchNode{T} end

#const  sname = ["filter", "must", "must_not", "query" , "nested", "has_child" ,"has_parent", "should"]

const ontype = Union{AbstractString, Expr}

function Base.push!(t::AbstractDict, b::AbstractDict)
	for (x,y) in b 
		push!(t, x => y)
	end 
end  

function make_loop(exprs::Vector )

	len = length(exprs)
	val = Array{Expr}(undef, length(exprs))
	
	for i in 1:len
		(methods, name, content)  = estrans(exprs[i])
		isa(name, ontype) || (name = string(name))
		val[i] =  :( $methods => Dict( $name  => $content) ) 
	end 

	esc(Expr( :call, :Dict, val... ))
end

function make_loop2(exprs::Vector )

	len = length(exprs)
	val = Array{Expr}(undef, length(exprs))
	
	for i in 1:len
		( methods , name, content)  = estrans(exprs[i])
		isa(name, ontype) || (name = string(name))
		val[i] = methods == nothing  ? :($name => $(content)[$name]) : :($name  => $content)
	end 

	esc(Expr( :call, :Dict, val... ))
end

function make_json(method::AbstractString, exprs::Vector )

	len = length(exprs)
	val = Array{Expr}(undef, length(exprs))
	
	for i in 1:len
		(methods, name, content)  = estrans(exprs[i])
		isa(name, ontype) || (name = string(name))

		if methods == nothing 
			val[i] =  :( "bool" => Dict( $name => $(content)[$name]) )
		else 
			val[i] =  :( $methods => Dict( $name  => $content) ) 
		end 
	end 
 	Expr( :call, :vcat, val... ) |> df -> esc(:(Dict($method => $df )))
end

function make_json(  exprs::Vector, type::AbstractString )

	len = length(exprs)
	val = Array{Expr}(undef, length(exprs))
	
	for i in 1:len
		( methods , name, content)  = estrans(exprs[i])
		isa(name, ontype) || (name = string(name))

		if methods == nothing
			val[i] =  :( $name => $(content)[$name] )
		else 
			val[i] =  :( $name  => $content)  
		end 
	end 
	Expr( :call, :Dict, val... ) |> df -> esc(:(Dict($type => $df)))
end

function make_json( exprs::Vector )

	len = length(exprs)
	val = Expr[]
	query = Expr[]
	
	for i in exprs
		( methods , name, content)  = estrans(i)
		isa(name, ontype) || (name = string(name))

		if methods == nothing 
			push!(query, :($name => $(content)[$name]  ))
		else 
			push!(val, :($name => $content ))
		end 
	end 
	
	vexp = Expr( :call, :Dict, val... )

	if ! isempty(query)
		qexp = Expr( :call, :Dict, query... ) |> df -> :(Dict("query" => Dict("bool" => $df)))
		esc(Expr( :call, :merge, vexp , qexp ))
	else 
		esc(vexp)
	end 

end

macro comm( expr...)
	return  make_loop(collect( expr )) 
end 

macro smi( expr...)
	return  make_loop2(collect( expr )) 
end
						
macro fulltext( expr... )
    return  make_json(collect( expr ) ,"query") 
end

macro filter( expr... )
    return  make_json( "filter", collect( expr ))
end
						
macro should( expr... )
    return  make_json( "should", collect( expr ))
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
    exp =  :($expr.keys[$expr.slots .!= 0][1])
    (nothing  , exp , :($expr[$exp]))
end
						
function estrans(::Type{SearchNode{:(*)}}, expr::Expr)
	("regexp" , expr.args[2] , expr.args[3] )
end 

function estrans(::Type{SearchNode{:(%)}}, expr::Expr)
	("wildcard" , expr.args[2] , expr.args[3] )
end 

function estrans(::Type{SearchNode{:(|)}}, expr::Expr)
	("prefix" , expr.args[2] , expr.args[3] )
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

syms(::Type{esyms{:<}})       = "gt"
syms(::Type{esyms{:(<=)}})    = "gte"
syms(::Type{esyms{:>}})       = "lt"
syms(::Type{esyms{:(>=)}})    = "lte" 

Base.:!(::Type{esyms{:<}})    = esyms{:>}
Base.:!(::Type{esyms{:(<=)}}) = esyms{:(>=)}
Base.:!(::Type{esyms{:>}})    = esyms{:<}
Base.:!(::Type{esyms{:(>=)}}) = esyms{:(<=)}

function estrans(::Type{SearchNode{:macrocall}}, expr::Expr)
	(nothing  , replace(string(expr.args[1]), "@" => "")  , expr)
end 

