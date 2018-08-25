# ES

using DataFrames
using JSON

include("es.jl")
using Main.ES

info  = Esinfo("", "9200")  
body1 = Dict( "id" => "es_log_filter" , 
			"params" => Dict("fieldid" => "event", 
						"fieldvalue" =>  ["onload"] , 
						"msize" =>  10 ))

res1  = esearch(info, "test" , body1, "_search/template", scroll="20s" ) 
id    = @esexp res1 "_scroll_id" 
num   = ceil( (@esexp @esexp( res1, "hits") "total" ) / 10000)  -1 
res1  = @esexp @esexp(res1, "hits") "hits"

for i = collect(1:num)
	escroll(info , id , "20s") |> df -> append!(res1, (@esexp @esexp(df, "hits") "hits"  ))
end 

result = [ @esexp(x ,"_source" )  for x in res1 ]
 
open("foo.json","w") do f  write(f, json(result ))  end

esupdate(info, "test123", "doc", result, collect(1:length(result)), true)
