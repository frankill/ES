__precompile__()

module ES

	using HTTP
	using JSON
	export Esinfo, escount, esearch ,esfsearch, escroll ,esbulkupdate,esbulkcript,esbulkindex,esbulkcreate
	export @esexp ,@esexport ,@query, @filter, @must, @must_not  ,@nested ,@has_child, @has_parent ,@fulltext,@common


	
	include("transformation.jl")
	include("api.jl")

end 
