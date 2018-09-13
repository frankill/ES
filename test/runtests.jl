using Distributed 
addprocs(5)

@everywhere using ES 

info     = Esinfo("", "") 
index = "201807"
setting = ES.esindexsetting(info, index)[index]["settings"]["index"]
shards = parse(Int, setting["number_of_shards"]) 

# 1
@distributed (vcat) for i in 0:shards-1  
	query= @common(slice= @query(id=i, max= shards) ) |>  df ->  merge(df , @query(size = 100) )  
	ES.esfsearch(info, index, query)  
end 


#2
@fulltext(match = @query(type = "test")) 
@fulltext(match = @query(type = "test"), bool = @filter(has("openid")))
@query(size = 1000, @filter(has("openid")))
@query(size = 1000, query = @filter(has("openid")))

						
#3
ES.esfsearch(info, index, @query(size=100) )
