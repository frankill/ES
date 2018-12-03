macro eshead( url , query  )

	esc(
		quote
			try 
				respos = HTTP.request("HEAD", HTTP.URI($(url)) , query= $query)

				if respos.status == 200 
					"OK"
				end
			catch 
				"404 - Not Found"
			end 

		end )
end

macro esdelete( url,   query   )

	esc(
		quote

			respos = HTTP.request("DELETE", HTTP.URI($(url)) ,  query= $query)

			if respos.status == 200 
				JSON.parse(String(respos.body))
			end

		end )
end
macro catexport(method, url , query  )

	esc(
		quote

			respos = HTTP.request($method, HTTP.URI($(url)), query= $query)
			String(respos.body) |> println

		end )
end

function genfunction(  kw::Vector  ) 

	func = Expr(:call , 
		kw[2] ,
		Expr(:parameters, 
			Expr(:(...), :kw)),
		Expr(:(::) , :info , :Esinfo)
		)

	url = :( url = makeurl( $(kw[3]), info ) )

	if length(kw) >= 5
		append!( url.args[2].args ,  kw[5:end] )
		append!(func.args, Expr.(:(::) , kw[5:end] , :AbstractString))	
	end 

	if kw[4] >= 1    
		push!(func.args,  Expr(:(::) , :body , :T) )
		body = :body 
	else 
		body = Dict()
	end 

	block = Expr(:block ,  
		:( querys = Dict(kw...) ),
		url ,
		Expr(:macrocall , 
				 Symbol("@esexport") ,
				 "",
				 kw[1],
				 :url ,
				 Expr(:call , :ifelse , Expr(:call, :isa, body, :Dict), 
							Expr(:call, :json, body) , body ) ,
				 :querys ,
				 "application/json"
				 )
			)

	esc(Expr(:function, Expr(:where , func,  
				Expr(:(<:) , :T , Expr(:curly,:Union, :Dict, :AbstractString))), block))

end 

macro genfunction( kw... )

	 genfunction( collect(kw) ) 

end 
