__precompile__()

module ES

	using HTTP
	using JSON
	export Esinfo, escount, esearch ,esfsearch, escroll ,esbulkupdate,esbulkcript,esbulkindex,esbulkcreate
	export xpacksql , xpacktranslate
	export @esexport ,@query, @filter, @must, @must_not ,@should  ,@nested ,@has_child, @has_parent ,@fulltext,@smi,@comm,@extra

	export esbulkdel,escreate,escrollclear,esdelete,esdelete_by_query,esdelete_by_query_rethrottle,
		esexists,esexists_source,esexplain,esfield_caps,esget,esgetscript,esgetsource,esindexsetting,
		esmget,esmtermvectors,esping,esputscript,esrankeval,esreindex,esreindex_rethrottle,
		esrender_search_template,esscripts_painless_execute,essearch_shards,esupdate,
		esupdate_by_query,esupdate_by_query_rethrottle,cataliases,catfielddata,esindex,
		catnodeattrs,catrecovery,catshards,cattemplates,catallocation,cathealth,catpending_tasks,
		catrepositories,catsnapshots,catthread_pool,catcount,catmaster,catplugins,catsegments,cattasks
	
	include("transformation.jl")
	include("api.jl")
	include("plugins.jl")
	include("cat.jl")
	include("other.jl")
	include("cluster_indices.jl")

end 
