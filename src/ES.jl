__precompile__()

module ES

	using HTTP
	using JSON
	export Esinfo, escount, esearch ,esfsearch, escroll ,esbulkupdate,esbulkcript,esbulkindex,esbulkcreate,esbulkdel
	export xpack_sql , xpack_sql_close, xpack_translate
	export @esexport ,@query, @filter, @must, @must_not ,@should  ,@nested ,@has_child, @has_parent ,@fulltext,@smi,@comm,@extra

	
	include("transformation.jl")
	include("api.jl")
	include("macro.jl")
	include("cat.jl")
	include("cluster_indices.jl")
	include("plugins.jl")
	include("other.jl")

end 
