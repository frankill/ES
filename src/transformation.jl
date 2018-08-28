struct MakeType{T} end  
struct SearchNode{T} end

const  sname = ["filter", "must", "must_not"]

function make_json(::Type{MakeType{:filter}}, exprs::Vector )
	quote
		len = length($exprs)
		val = Array{Dict}(undef, length($exprs))
		for i in 1:len
			(methods, name, content)  = trans($exprs[i])
			val[i] = Dict(methods => Dict(name => eval(content ))) 
		end 
		Dict("filter" => val)
	end 	
end
 

macro filter( expr... )
    return make_json( MakeType{:filter}, collect( expr ))
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
	("range" , expr.args[2] , expr.args[3] )
end 

 
