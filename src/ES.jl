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
	
	export esindices_analyze,esindices_clear_cache,esindices_close,esindices_create,esindices_flush,
		esindices_flush_synced,esindices_forcemerge,esindices_get,esindices_get_alias,
		esindices_get_field_mapping,escluster_allocation_explain,escluster_get_settings,escluster_health,
		esingest_processor_grok,esingest_get_pipeline,essnapshot_create,esnodes_info,esnodes_hot_threads,
		essnapshot_create_repository,essnapshot_get,estasks_cancel,estasks_get,estasks_get_pipeline,estasks_list,
		esindices_get_mapping,esindices_get_settings,esindices_get_template,esindices_get_upgrade,esindices_open,
		esindices_put_alias,esindices_put_mapping,esindices_put_settings,esindices_put_template,esindices_recovery,
		escluster_pending_tasks,escluster_put_settings,escluster_remote_info,esingest_put_pipeline,
		esnodes_reload_secure_settings,esnodes_stats,essnapshot_get_repository,essnapshot_restore,essnapshot_status,
		esindices_refresh,esindices_rollover,esindices_segments,esindices_shard_stores,esindices_shrink,
		esindices_split,esindices_stats,esindices_update_aliases,esindices_upgrade,esindices_validate_query,
		escluster_reroute,escluster_state,escluster_stats,esingest_simulate,esnodes_usage,essnapshot_verify_repository
	

	include("macro.jl")
	include("transformation.jl")
	include("api.jl")
	include("cat.jl")
	include("cluster_indices.jl")
	include("plugins.jl")
	include("other.jl")

end 
