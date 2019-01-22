macro eshead(info,  url , query  )

	esc(
		quote
			try
				respos = HTTP.request("HEAD", HTTP.URI($(url)), $(info).jheader , query= $query ;  $(info).conf...)

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
			respos = HTTP.request("DELETE", HTTP.URI($(url)) , $(info).jheader,  query= $query ;  $(info).conf...)

			if respos.status == 200
				JSON.parse(String(respos.body))
			end

		end )
end
macro catexport(info, method, url , query  )
	esc(
		quote
			respos = HTTP.request($method, HTTP.URI($(url)), $(info).jheader, query= $query ;  $(info).conf...)
			String(respos.body) |> println
		end )
end

macro esexp(x,y)
	esc(:(get($x, $y, missing)))
end

macro esexport(info, method, url, body , query , header )
	esc(
		quote

			respos = HTTP.request($method, HTTP.URI($(url)) , $header , $body, query= $query;  $(info).conf...)

			if respos.status == 200
				JSON.parse(String(respos.body))
			end

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
				 Expr(:(.), :info , :(:jheader))
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
