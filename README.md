
# For personal testing only.

#using DataFrames
using JSON
using ES

info  = Esinfo("host", "9200")  
body1 = Dict( "id" => "es_log_filter" , 
			"params" => Dict("fieldid" => "event", 
						"fieldvalue" =>  ["onload"] , 
						"msize" =>  10 ))

res1  = esearch(info, "track_data" , body1, "_search/template", scroll="20s" ) 

id    = @esexp res1 "_scroll_id" 

num   = ceil( (@esexp @esexp( res1, "hits") "total" ) / 10000)  -1 

res1  = @esexp @esexp(res1, "hits") "hits"

for i = collect(1:num)
	escroll(info , id , "20s") |> df -> append!(res1, (@esexp @esexp(df, "hits") "hits"  ))
end 

result = [ @esexp(x ,"_source" )  for x in res1 ]

a =ES.esbulkindex(info, "test123", "doc", result, collect(1:length(result))  )
 
 
 #test 
const inname = ["openid","data.longitude", "data.latitude"]

const etime  = datetime2unix(now(UTC)) |> df -> round(Int,df)*1000

const stime  = datetime2unix(now(UTC) - Second(300)) |> df -> round(Int,df)*1000

esfilter = @filter(has("data.latitude") , local_time > stime , local_time < etime  )  

querys   = @query(size=10000, _source in inname,  filter = esfilter)  |>  json 
