__precompile__(true)

module ES

	using HTTP
	using JSON
	import Base64: base64encode
	export Esinfo,cat_aliases,cat_allocation,cat_count,cat_fielddata,cat_health,cat_master,cat_nodeattrs,cat_pending_tasks,
		cat_plugins,cat_recovery,cat_repositories,cat_segments,cat_shards,cat_snapshots,cat_tasks,cat_templates,cat_thread_pool,
		es_indices_shrink,es_indices_split,es_indices_stats,es_indices_update_aliases,es_indices_upgrade,es_indices_validate_query,
		es_ingest_get_pipeline,es_ingest_processor_grok,es_ingest_put_pipeline,es_ingest_simulate,es_mtermvectors,es_nodes_hot_threads,
		es_nodes_info,es_nodes_reload_secure_settings,es_nodes_stats,es_nodes_usage,es_ping,es_put_script,es_rank_eval,es_reindex,
		es_reindex_rethrottle,es_render_search_template,es_scripts_painless_execute,es_scroll,es_scroll_clear,es_search,
		es_search_shards,es_searchs,es_snapshot_create,es_snapshot_create_repository,es_snapshot_get,es_snapshot_get_repository,
		es_snapshot_restore,es_snapshot_status,es_snapshot_verify_repository,es_tasks_cancel,es_tasks_get,es_tasks_list,
		es_update,es_update_by_query,es_update_by_query_rethrottle,xpack_sql,xpack_sql_close,xpack_translate,es_bulk_create,
		es_bulk_del,es_bulk_index,es_bulk_script,es_bulk_update,es_cluster_allocation_explain,es_cluster_get_settings,
		es_cluster_health,es_cluster_pending_tasks,es_cluster_put_settings,es_cluster_remote_info,es_cluster_reroute,
		es_cluster_state,es_cluster_stats,es_count,es_create,es_delete,es_delete_by_query,es_delete_by_query_rethrottle,
		es_exists,es_exists_source,es_explain,es_field_caps,es_get,es_getscript,es_getsource,es_index,es_indices_analyze,
		es_indices_clear_cache,es_indices_close,es_indices_create,es_indices_delete,es_indices_delete_alias,
		es_indices_delete_template,es_indices_exists,es_indices_exists_alias,es_indices_exists_template,
		es_indices_flush,es_indices_flush_synced,es_indices_forcemerge,es_indices_get,es_indices_get_alias,
		es_indices_get_field_mapping,es_indices_get_mapping,es_indices_get_settings,es_indices_get_template,es_indices_get_upgrade,
		es_indices_open,es_indices_put_alias,es_indices_put_mapping,es_indices_put_settings,es_indices_put_template,
		es_indices_recovery,es_indices_refresh,es_indices_rollover,es_indices_segments,es_indices_shard_stores

	export @esexport ,@query, @filter, @must, @must_not ,@should  ,@nested ,@has_child, @has_parent ,@fulltext,@smi,@comm,@extra
	export BulkLength

	struct Esinfo
		host::AbstractString
		port::AbstractString
		transport::AbstractString
		base64::AbstractString
		url::AbstractString
		jheader::Vector{Pair{String,String}}
		nheader::Vector{Pair{String,String}}
		conf::NamedTuple
	
		function Esinfo(; host::AbstractString ,port::AbstractString ,user::AbstractString  ,pwd::AbstractString , transport::AbstractString= "https")
			ur = string(transport, "://", host, ":", port)
			basetmp = base64encode( user , ":", pwd)
			jheader= ["content-type" => "application/json", "Authorization" => string( "Basic" , " ", basetmp ) ]
			nheader= ["content-type" => "application/x-ndjson", "Authorization" => string( "Basic" , " ", basetmp ) ]
			conf = ( require_ssl_verification = false, basic_authorization = true)
			new( host,  port,  transport , basetmp , ur, jheader, nheader, conf )
		end

		function Esinfo(host::AbstractString ,port::AbstractString , transport::AbstractString="http")
			ur = string(transport, "://", host, ":", port)
			jheader= ["content-type" => "application/json" ]
			nheader= ["content-type" => "application/x-ndjson"  ]
			new( host,  port,  transport, "", ur , jheader, nheader, NamedTuple() )
		end
	
		function Esinfo(host::AbstractString ,port::AbstractString ,base64::AbstractString ,
			 						jheader::Vector{Pair{String,String}},
									nheader::Vector{Pair{String,String}},
									conf::NamedTuple,
									transport::AbstractString= "https")
			ur = string(transport, "://", host, ":", port)
			new( host,  port,  transport , base64 , ur, jheader, nheader, conf )
		end

	end


	Esinfo(host::AbstractString) = Esinfo(host, "9200")

	include("macro.jl")
	include("transformation.jl")
	include("api.jl")
	include("cat.jl")
	include("cluster_indices.jl")
	include("plugins.jl")
	include("other.jl")

end
