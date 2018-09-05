__precompile__()

module ES

	using HTTP
	using JSON
	export Esinfo, escount, esearch ,escroll, estrans ,sname ,esbulkupdate,esbulkcript,esbulkindex,esbulkcreate
	export @esexp ,@esexport ,@query, @filter, @must, @must_not  ,@nested ,@has_child, @has_parent ,@fulltext


	include("api.jl")
	include("transformation.jl")

end 
