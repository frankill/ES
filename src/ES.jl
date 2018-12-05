__precompile__()

module ES

	using HTTP
	using JSON
	export Esinfo, es_count, es_search ,es_searchs, es_scroll ,es_bulk_update,es_bulk_script,es_bulk_index,es_bulk_create,es_bulk_del
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
