struct SearchNode{T} end

const  sname = ["filter", "must", "must_not", "query" , "nested"]

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
				(methods, name, content)  = trans($exprs[i])
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
				(methods, name, content)  = trans($exprs[i])
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
				(methods, name, content)  = trans($exprs[i])
				
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


function trans( expr::Expr )
    trans( SearchNode{expr.head}, expr)
end

function trans( ::Type{SearchNode{:call}}, expr::Expr)
     trans(SearchNode{expr.args[1]}, expr)
end

function trans(::Type{SearchNode{:(=)}}, expr::Expr)
	("term" , expr.args[1] ,  expr.args[2] )
end 

function trans(::Type{SearchNode{:(in)}}, expr::Expr)
	("terms" , expr.args[2] , expr.args[3] )
end 

function trans(::Type{SearchNode{:(has)}}, expr::Expr)
	("exists" , "field" , expr.args[2] )
end 

function trans(::Type{SearchNode{:(>)}}, expr::Expr)
	("range" , expr.args[2] , :(Dict( "gte" => $(expr.args[3])) ))
end 

function trans(::Type{SearchNode{:(<)}}, expr::Expr)
	("range" , expr.args[2] , :(Dict( "lte" => $(expr.args[3])) ))
end 
