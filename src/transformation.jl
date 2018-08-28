struct MakeType{T} end  
struct SearchNode{T} end

const  sname = ["filter", "must", "must_not"]

function make_json(method::AbstractString, exprs::Vector )
	quote
		len = length($exprs)
		val = Array{Dict}(undef, length($exprs))
		
		for i in 1:len
			(methods, name, content)  = trans($exprs[i])
			val[i] = Dict(methods => Dict(name => eval(content ))) 
		end 
		
		Dict($method => val)
	end 	
end

function make_json( exprs::Vector )
	quote
		len = length($exprs)
		val = Array{Dict}(undef, length($exprs))
		
		for i in 1:len
			(methods, name, content)  = trans($exprs[i])
			val[i] = Dict(methods => Dict(name => eval(content ))) 
		end 
		
		Dict("query" => Dict("bool" => val))
	 
	end 	
end
 
macro filter( expr... )
    return make_json( "filter", collect( expr ))
end

macro must( expr... )
    return make_json( "must", collect( expr ))
end

macro must_not( expr... )
    return make_json( "must_not", collect( expr ))
end

macro query( expr... )
    return make_json( collect( expr ))
end


function trans( expr::Expr )
    trans( SearchNode{expr.head}, expr)
end

function trans( ::Type{SearchNode{:call}}, expr::Expr)
     trans(SearchNode{expr.args[1]}, expr)
end

function trans(::Type{SearchNode{:(=)}}, expr::Expr)
	("term" , expr.args[1] , expr.args[2] )
end 

function trans(::Type{SearchNode{:(in)}}, expr::Expr)
	("terms" , expr.args[2] , expr.args[3] )
end 

function trans(::Type{SearchNode{:(has)}}, expr::Expr)
	("exists" , "field" , expr.args[2] )
end 

function trans(::Type{SearchNode{:(>)}}, expr::Expr)
	("range" , expr.args[2] , Expr(:call, :Dict , "gte" => expr.args[3]) )
end 

function trans(::Type{SearchNode{:(<)}}, expr::Expr)
	("range" , expr.args[2] , Expr(:call, :Dict , "lte" => expr.args[3]) )
end 
 
