macro eshead(info,  url , query  )

	esc(
		quote
			try
				if ! isempty( $(info).base64 )
					 header  = ["Authorization" => string( "Basic" , " ", $(info).base64 ) ]
					 conf = ( require_ssl_verification = false, basic_authorization = true)
					 respos = HTTP.request("HEAD", HTTP.URI($(url)), header , query= $query ; conf...)
				else
					respos = HTTP.request("HEAD", HTTP.URI($(url)) , query= $query )
				end

				if respos.status == 200
					"OK"
				end
			catch
				"Fail"
			end

		end )
end

macro esdelete(info,  url,   query   )
	esc(
		quote
			if ! isempty( $(info).base64 )
				 header  = ["Authorization" => string( "Basic" , " ", $(info).base64 ) ]
				 conf = ( require_ssl_verification = false, basic_authorization = true)
				 respos = HTTP.request("DELETE", HTTP.URI($(url)) , header,  query= $query ; conf...)
			else
				respos = HTTP.request("DELETE", HTTP.URI($(url)) ,  query= $query )
			end

			if respos.status == 200
				JSON.parse(String(respos.body))
			end

		end )
end
macro catexport(info, method, url , query  )
	esc(
		quote
			if ! isempty( $(info).base64 )
				 header  = ["Authorization" => string( "Basic" , " ", $(info).base64 ) ]
				 conf = ( require_ssl_verification = false, basic_authorization = true)
				 respos = HTTP.request($method, HTTP.URI($(url)), header, query= $query ; conf...)
			else
				respos = HTTP.request($method, HTTP.URI($(url)), query= $query)
			end

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

	url = :( url = make_url( $(kw[3]), info ) )

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
				 :info,
				 kw[1],
				 :url ,
				 Expr(:call , :ifelse , Expr(:call, :isa, body, :Dict),
							Expr(:call, :json, body) , body ) ,
				 :querys ,
				 "application/json"
				 )
			)
	if kw[4] >= 1
		esc(Expr(:function, Expr(:where , func,
					Expr(:(<:) , :T , Expr(:curly,:Union, :Dict, :AbstractString))), block))
	else
		esc(Expr(:function, func, block))
	end

end

macro genfunction( kw... )

	 genfunction( collect(kw) )

end
