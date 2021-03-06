struct ClusterType{T} end
struct IndicesType{T} end
struct IngestType{T} end
struct NodesType{T} end
struct SnapshotType{T} end
struct TasksType{T} end

function make_url(::Type{ClusterType{:_allocation_explain}}, info::Esinfo)
	"$(info.url)/_cluster/allocation/explain"
end

function make_url(::Type{ClusterType{:_get_settings}}, info::Esinfo)
	"$(info.url)/_cluster/settings"
end

function make_url(::Type{ClusterType{:_health}}, info::Esinfo, index::AbstractString)
	"$(info.url)/_cluster/health/$index"
end

function make_url(::Type{ClusterType{:_health}}, info::Esinfo)
	"$(info.url)/_cluster/health/"
end

function make_url(::Type{ClusterType{:_pending_tasks}}, info::Esinfo)
	"$(info.url)/_cluster/pending_tasks"
end

function make_url(::Type{ClusterType{:_put_settings}}, info::Esinfo)
	"$(info.url)/_cluster/settings"
end

function make_url(::Type{ClusterType{:_remote_info}}, info::Esinfo)
	"$(info.url)/_remote/info"
end

function make_url(::Type{ClusterType{:_reroute}}, info::Esinfo)
	"$(info.url)/_cluster/reroute"
end

function make_url(::Type{ClusterType{:_state}}, info::Esinfo)
	"$(info.url)/_cluster/state"
end

function make_url(::Type{ClusterType{:_state}}, info::Esinfo, metric::AbstractString)
	"$(info.url)/_cluster/state/$metric"
end

function make_url(::Type{ClusterType{:_state}}, info::Esinfo, metric::AbstractString, index::AbstractString)
	"$(info.url)/_cluster/state/$metric/$index"
end

function make_url(::Type{ClusterType{:_stats}}, info::Esinfo, node_id::AbstractString)
	"$(info.url)/_cluster/stats/nodes/$node_id/"
end

function make_url(::Type{ClusterType{:_stats}}, info::Esinfo)
	"$(info.url)/_cluster/stats"
end

function make_url(::Type{IndicesType{:_analyze}}, info::Esinfo)
	"$(info.url)/_analyze"
end

function make_url(::Type{IndicesType{:_analyze}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_analyze"
end

function make_url(::Type{IndicesType{:_clear_cache}}, info::Esinfo)
	"$(info.url)/_cache/clear"
end

function make_url(::Type{IndicesType{:_clear_cache}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_cache/clear"
end

function make_url(::Type{IndicesType{:_close}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_close"
end

function make_url(::Type{IndicesType{:_create}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index"
end

function make_url(::Type{IndicesType{:_delete}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index"
end

function make_url(::Type{IndicesType{:_delete_alias}}, info::Esinfo, index::AbstractString, name::AbstractString)
	"$(info.url)/$index/_alias/$name"
end

function make_url(::Type{IndicesType{:_delete_template}}, info::Esinfo, name::AbstractString)
	"$(info.url)/_template/$name"
end

function make_url(::Type{IndicesType{:_exists}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index"
end

function make_url(::Type{IndicesType{:_exists_alias}}, info::Esinfo, name::AbstractString)
	"$(info.url)/_alias/$name"
end

function make_url(::Type{IndicesType{:_exists_alias}}, info::Esinfo, index::AbstractString,name::AbstractString)
	"$(info.url)/$index/_alias/$name"
end

function make_url(::Type{IndicesType{:_exists_template}}, info::Esinfo, name::AbstractString)
	"$(info.url)/_template/$name"
end

function make_url(::Type{IndicesType{:_exists_type}}, info::Esinfo, index::AbstractString, type::AbstractString)
	"$(info.url)/$index/_mapping/$type"
end

function make_url(::Type{IndicesType{:_flush}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_flush"
end

function make_url(::Type{IndicesType{:_flush}}, info::Esinfo)
	"$(info.url)/_flush"
end

function make_url(::Type{IndicesType{:_flush_synced}}, info::Esinfo)
	"$(info.url)/_flush/synced"
end

function make_url(::Type{IndicesType{:_forcemerge}}, info::Esinfo)
	"$(info.url)/_forcemerge"
end

function make_url(::Type{IndicesType{:_forcemerge}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_forcemerge"
end

function make_url(::Type{IndicesType{:_get}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index"
end

function make_url(::Type{IndicesType{:_get_alias}}, info::Esinfo)
	"$(info.url)/_alias"
end

function make_url(::Type{IndicesType{:_get_alias}}, info::Esinfo, name::AbstractString)
	"$(info.url)/_alias/$name"
end

function make_url(::Type{IndicesType{:_get_alias}}, info::Esinfo, index::AbstractString, name::AbstractString)
	"$(info.url)/$index/_alias/$name"
end

function make_url(::Type{IndicesType{:_get_field_mapping}}, info::Esinfo, fields::AbstractString)
	"$(info.url)/_mapping/field/$fields"
end

function make_url(::Type{IndicesType{:_get_field_mapping}}, info::Esinfo, index::AbstractString, fields::AbstractString)
	"$(info.url)/$index/_mapping/field/$fields"
end

function make_url(::Type{IndicesType{:_get_mapping}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_mapping"
end

function make_url(::Type{IndicesType{:_get_mapping}}, info::Esinfo)
	"$(info.url)/_mapping"
end

function make_url(::Type{IndicesType{:_get_settings}}, info::Esinfo)
	"$(info.url)/_settings"
end

function make_url(::Type{IndicesType{:_get_settings}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_settings"
end

function make_url(::Type{IndicesType{:_get_template}}, info::Esinfo, name::AbstractString)
	"$(info.url)/_template/$name"
end

function make_url(::Type{IndicesType{:_get_template}}, info::Esinfo)
	"$(info.url)/_template"
end

function make_url(::Type{IndicesType{:_get_upgrade}}, info::Esinfo)
	"$(info.url)/_upgrade"
end

function make_url(::Type{IndicesType{:_get_upgrade}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_upgrade"
end

function make_url(::Type{IndicesType{:_open}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_open"
end

function make_url(::Type{IndicesType{:_put_alias}}, info::Esinfo )
	"$(info.url)/_aliases"
end

function make_url(::Type{IndicesType{:_put_alias}}, info::Esinfo ,index::AbstractString, name::AbstractString )
	"$(info.url)/$index/_alias/$name"
end

function make_url(::Type{IndicesType{:_put_mapping}}, info::Esinfo ,index::AbstractString, type::AbstractString )
	"$(info.url)/$index/_mapping/$type"
end

function make_url(::Type{IndicesType{:_put_mapping}}, info::Esinfo ,index::AbstractString  )
	"$(info.url)/$index"
end

function make_url(::Type{IndicesType{:_put_settings}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_settings"
end

function make_url(::Type{IndicesType{:_put_settings}}, info::Esinfo )
	"$(info.url)/_settings"
end

function make_url(::Type{IndicesType{:_put_template}}, info::Esinfo, name::AbstractString)
	"$(info.url)/_template/$name"
end

function make_url(::Type{IndicesType{:_recovery}}, info::Esinfo )
	"$(info.url)/_recovery"
end

function make_url(::Type{IndicesType{:_recovery}}, info::Esinfo, name::AbstractString)
	"$(info.url)/$index/_recovery"
end

function make_url(::Type{IndicesType{:_refresh}}, info::Esinfo, name::AbstractString)
	"$(info.url)/$index/_refresh"
end

function make_url(::Type{IndicesType{:_refresh}}, info::Esinfo )
	"$(info.url)/_refresh"
end

function make_url(::Type{IndicesType{:_rollover}}, info::Esinfo, alias::AbstractString)
	"$(info.url)/$alias/_rollover"
end

function make_url(::Type{IndicesType{:_rollover}}, info::Esinfo, alias::AbstractString, new_index::AbstractString)
	"$(info.url)/$alias/_rollover/$new_index"
end

function make_url(::Type{IndicesType{:_segments}}, info::Esinfo )
	"$(info.url)/_segments"
end

function make_url(::Type{IndicesType{:_segments}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_segments"
end

function make_url(::Type{IndicesType{:_shard_stores}}, info::Esinfo )
	"$(info.url)/_shard_stores"
end

function make_url(::Type{IndicesType{:_shard_stores}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_shard_stores"
end

function make_url(::Type{IndicesType{:_shrink}}, info::Esinfo, index::AbstractString, target::AbstractString)
	"$(info.url)/$index/_shrink/$target"
end

function make_url(::Type{IndicesType{:_split}}, info::Esinfo, index::AbstractString, target::AbstractString)
	"$(info.url)/$index/_split/$target"
end

function make_url(::Type{IndicesType{:_stats}}, info::Esinfo )
	"$(info.url)/_stats"
end

function make_url(::Type{IndicesType{:_stats}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_stats"
end

function make_url(::Type{IndicesType{:_update_aliases}}, info::Esinfo)
	"$(info.url)/_aliases"
end

function make_url(::Type{IndicesType{:_upgrade}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_upgrade"
end

function make_url(::Type{IndicesType{:_upgrade}}, info::Esinfo)
	"$(info.url)/_upgrade"
end

function make_url(::Type{IndicesType{:_validate_query}}, info::Esinfo, index::AbstractString)
	"$(info.url)/$index/_validate/query"
end

function make_url(::Type{IndicesType{:_validate_query}}, info::Esinfo)
	"$(info.url)/_validate/query"
end

function make_url(::Type{IngestType{:_delete_pipeline}}, info::Esinfo, id::AbstractString)
	"$(info.url)/_ingest/pipeline/$id"
end

function make_url(::Type{IngestType{:_get_pipeline}}, info::Esinfo)
	"$(info.url)/_ingest/pipeline"
end

function make_url(::Type{IngestType{:_get_pipeline}}, info::Esinfo, id::AbstractString)
	"$(info.url)/_ingest/pipeline/$id"
end

function make_url(::Type{IngestType{:_processor_grok}}, info::Esinfo)
	"$(info.url)/_ingest/processor/grok"
end

function make_url(::Type{IngestType{:_put_pipeline}}, info::Esinfo, id::AbstractString)
	"$(info.url)/_ingest/pipeline/$id"
end

function make_url(::Type{IngestType{:_simulate}}, info::Esinfo)
	"$(info.url)/_ingest/pipeline/_simulate"
end

function make_url(::Type{IngestType{:_simulate}}, info::Esinfo, id::AbstractString)
	"$(info.url)/_ingest/pipeline/$id/_simulate"
end

function make_url(::Type{NodesType{:_hot_threads}}, info::Esinfo, id::AbstractString)
	"$(info.url)/_nodes/$id/hot_threads"
end

function make_url(::Type{NodesType{:_hot_threads}}, info::Esinfo)
	"$(info.url)/_nodes/hot_threads"
end

function make_url(::Type{NodesType{:_info}}, info::Esinfo, node_id_metric::AbstractString)
	"$(info.url)/_nodes/$node_id_metric"
end

function make_url(::Type{NodesType{:_info}}, info::Esinfo)
	"$(info.url)/_nodes/hot_threads"
end

function make_url(::Type{NodesType{:_info}}, info::Esinfo, node_id::AbstractString, metric::AbstractString)
	"$(info.url)/_nodes/$node_id/$metric"
end

function make_url(::Type{NodesType{:_reload_secure_settings}}, info::Esinfo, node_id::AbstractString)
	"$(info.url)/_nodes/$node_id/reload_secure_settings"
end

function make_url(::Type{NodesType{:_reload_secure_settings}}, info::Esinfo)
	"$(info.url)/_nodes/reload_secure_settings"
end

function make_url(::Type{NodesType{:_usage}}, info::Esinfo, node_id::AbstractString)
	"$(info.url)/_nodes/$node_id/usage"
end

function make_url(::Type{NodesType{:_usage}}, info::Esinfo)
	"$(info.url)/_nodes/usage"
end

function make_url(::Type{NodesType{:_stats}}, info::Esinfo, node_id::AbstractString)
	"$(info.url)/_nodes/$node_id/stats"
end

function make_url(::Type{NodesType{:_stats}}, info::Esinfo)
	"$(info.url)/_nodes/stats"
end

function make_url(::Type{SnapshotType{:_snapshot}}, info::Esinfo, repository::AbstractString, snapshot::AbstractString)
	"$(info.url)/_snapshot/$repository/$snapshot"
end

function make_url(::Type{SnapshotType{:_snapshot_repository}}, info::Esinfo, repository::AbstractString)
	"$(info.url)/_snapshot/$repository"
end

function make_url(::Type{SnapshotType{:_get_repository}}, info::Esinfo)
	"$(info.url)/_snapshot/"
end

function make_url(::Type{SnapshotType{:_restore}}, info::Esinfo, repository::AbstractString, snapshot::AbstractString)
	"$(info.url)/_snapshot/$repository/$snapshot/_restore"
end

function make_url(::Type{SnapshotType{:_status}}, info::Esinfo, repository::AbstractString, snapshot::AbstractString)
	"$(info.url)/_snapshot/$repository/$snapshot/_status"
end

function make_url(::Type{SnapshotType{:_status}}, info::Esinfo, repository::AbstractString)
	"$(info.url)/_snapshot/$repository/_status"
end

function make_url(::Type{SnapshotType{:_status}}, info::Esinfo)
	"$(info.url)/_snapshot/_status"
end

function make_url(::Type{SnapshotType{:_verify_repository}}, info::Esinfo, repository::AbstractString)
	"$(info.url)/_snapshot/$repository/_verify"
end

function make_url(::Type{TasksType{:_list}}, info::Esinfo)
	"$(info.url)/_tasks"
end

function make_url(::Type{TasksType{:_get}}, info::Esinfo, task_id::AbstractString)
	"$(info.url)/_tasks/$task_id"
end

function make_url(::Type{TasksType{:_cancel}}, info::Esinfo)
	"$(info.url)/_tasks/_cancel"
end

function make_url(::Type{TasksType{:_cancel}}, info::Esinfo, task_id::AbstractString)
	"$(info.url)/_tasks/$task_id/_cancel"
end

#task
@genfunction "POST" es_tasks_cancel TasksType{:_cancel} 0 task_id
@genfunction "POST" es_tasks_cancel TasksType{:_cancel} 0
@genfunction "GET" es_tasks_get TasksType{:_get} 0 task_id
@genfunction "GET" es_tasks_list TasksType{:_list} 0

#snapshot
@genfunction "POST" es_snapshot_verify_repository SnapshotType{:_verify_repository} 0 repository
@genfunction "GET" es_snapshot_status SnapshotType{:_status} 0  repository snapshot
@genfunction "GET" es_snapshot_status SnapshotType{:_status} 0  repository
@genfunction "GET" es_snapshot_status SnapshotType{:_status} 0
@genfunction "POST" es_snapshot_restore SnapshotType{:_restore} 1  repository snapshot
@genfunction "GET" es_snapshot_get_repository SnapshotType{:_snapshot_repository} 0 repository
@genfunction "GET" es_snapshot_get_repository SnapshotType{:_get_repository} 0
@genfunction "GET" es_snapshot_get SnapshotType{:_snapshot} 0  repository snapshot
@genfunction "POST" es_snapshot_create_repository SnapshotType{:_snapshot_repository} 1 repository
@genfunction "POST" es_snapshot_create SnapshotType{:_snapshot} 1 repository snapshot

#nodes
@genfunction "GET" es_nodes_usage NodesType{:_usage} 0 node_id
@genfunction "GET" es_nodes_usage NodesType{:_usage} 0
@genfunction "GET" es_nodes_stats NodesType{:_stats} 0 node_id
@genfunction "GET" es_nodes_stats NodesType{:_stats} 0
@genfunction "GET" es_nodes_reload_secure_settings NodesType{:_reload_secure_settings} 0 node_id
@genfunction "GET" es_nodes_reload_secure_settings NodesType{:_reload_secure_settings} 0

#ingest
@genfunction "GET" es_ingest_simulate IngestType{:_simulate} 1 id
@genfunction "GET" es_ingest_simulate IngestType{:_simulate} 1
@genfunction "PUT" es_ingest_put_pipeline IngestType{:_put_pipeline} 1 id
@genfunction "GET" es_ingest_processor_grok IngestType{:_processor_grok} 0
@genfunction "GET" es_ingest_get_pipeline IngestType{:_get_pipeline} 0 id
@genfunction "GET" es_ingest_get_pipeline IngestType{:_get_pipeline} 0

#indices
@genfunction "POST" es_indices_validate_query IndicesType{:_validate_query} 1 index
@genfunction "POST" es_indices_validate_query IndicesType{:_validate_query} 1
@genfunction "POST" es_indices_upgrade IndicesType{:_upgrade} 1 index
@genfunction "POST" es_indices_upgrade IndicesType{:_upgrade} 1
@genfunction "POST" es_indices_update_aliases IndicesType{:_update_aliases} 1
@genfunction "GET" es_indices_stats IndicesType{:_stats} 0 index
@genfunction "GET" es_indices_stats IndicesType{:_stats} 0
@genfunction "POST" es_indices_split IndicesType{:_split} 1 index target
@genfunction "POST" es_indices_shrink IndicesType{:_shrink} 1 index target
@genfunction "GET" es_indices_shard_stores IndicesType{:_shard_stores} 0 index
@genfunction "GET" es_indices_shard_stores IndicesType{:_shard_stores} 0
@genfunction "GET" es_indices_segments IndicesType{:_segments} 0 index
@genfunction "GET" es_indices_segments IndicesType{:_segments} 0
@genfunction "POST" es_indices_rollover IndicesType{:_rollover} 1 alias new_index
@genfunction "POST" es_indices_rollover IndicesType{:_rollover} 1 alias
@genfunction "GET" es_indices_refresh IndicesType{:_refresh} 0 index
@genfunction "GET" es_indices_refresh IndicesType{:_refresh} 0
@genfunction "GET" es_indices_recovery IndicesType{:_recovery} 0 index
@genfunction "GET" es_indices_recovery IndicesType{:_recovery} 0
@genfunction "POST" es_indices_put_template IndicesType{:_put_template} 1 name
@genfunction "PUT" es_indices_put_settings IndicesType{:_put_settings} 1 index
@genfunction "PUT" es_indices_put_settings IndicesType{:_put_settings} 1
@genfunction "PUT" es_indices_put_mapping IndicesType{:_put_mapping} 1 index type
@genfunction "PUT" es_indices_put_mapping IndicesType{:_put_mapping} 1 index
@genfunction "PUT" es_indices_put_alias IndicesType{:_put_alias} 1 index name
@genfunction "PUT" es_indices_put_alias IndicesType{:_put_alias} 1
@genfunction "POST" es_indices_open IndicesType{:_open} 0 index
@genfunction "GET" es_indices_get_upgrade IndicesType{:_get_upgrade} 0 index
@genfunction "GET" es_indices_get_upgrade IndicesType{:_get_upgrade} 0
@genfunction "GET" es_indices_get_template IndicesType{:_get_template} 0 name
@genfunction "GET" es_indices_get_template IndicesType{:_get_template} 0
@genfunction "GET" es_indices_get_settings IndicesType{:_get_settings} 0 index
@genfunction "GET" es_indices_get_settings IndicesType{:_get_settings} 0
@genfunction "GET" es_indices_get_mapping IndicesType{:_get_mapping} 0 index
@genfunction "GET" es_indices_get_mapping IndicesType{:_get_mapping} 0
@genfunction "GET" es_indices_get_field_mapping IndicesType{:_get_field_mapping} 0 index fields
@genfunction "GET" es_indices_get_field_mapping IndicesType{:_get_field_mapping} 0 fields
@genfunction "GET" es_indices_get_alias IndicesType{:_get_alias} 0
@genfunction "GET" es_indices_get_alias IndicesType{:_get_alias} 0 index
@genfunction "GET" es_indices_get_alias IndicesType{:_get_alias} 0 index name
@genfunction "GET" es_indices_get IndicesType{:_get} 0 index
@genfunction "POST" es_indices_forcemerge IndicesType{:_forcemerge} 0
@genfunction "POST" es_indices_forcemerge IndicesType{:_forcemerge} 0 index
@genfunction "POST" es_indices_flush_synced IndicesType{:_flush_synced} 0
@genfunction "POST" es_indices_flush IndicesType{:_flush} 0
@genfunction "POST" es_indices_flush IndicesType{:_flush} 0 index
@genfunction "POST" es_indices_close IndicesType{:_close} 0 index
@genfunction "PUT" es_indices_create IndicesType{:_create} 1 index
@genfunction "POST" es_indices_clear_cache IndicesType{:_clear_cache} 0
@genfunction "POST" es_indices_clear_cache IndicesType{:_clear_cache} 0 index
@genfunction "POST" es_indices_analyze IndicesType{:_analyze} 1
@genfunction "POST" es_indices_analyze IndicesType{:_analyze} 1 index

# cluster
@genfunction "GET" es_cluster_stats ClusterType{:_stats} 0
@genfunction "GET" es_cluster_stats ClusterType{:_stats} 0 node_id
@genfunction "GET" es_cluster_state ClusterType{:_state} 0 metric index
@genfunction "GET" es_cluster_state ClusterType{:_state} 0 metric
@genfunction "GET" es_cluster_state ClusterType{:_state} 0
@genfunction "GET" es_cluster_reroute ClusterType{:_reroute} 0
@genfunction "GET" es_cluster_remote_info ClusterType{:_remote_info} 0
@genfunction "PUT" es_cluster_put_settings ClusterType{:_put_settings} 1
@genfunction "GET" es_cluster_pending_tasks ClusterType{:_pending_tasks} 0
@genfunction "GET" es_cluster_health ClusterType{:_health} 0 index
@genfunction "GET" es_cluster_health ClusterType{:_health} 0
@genfunction "GET" es_cluster_get_settings ClusterType{:_get_settings} 0
@genfunction "GET" es_cluster_allocation_explain ClusterType{:_allocation_explain} 1

# @genfunction "GET" esnodes_info NodesType{:_info} 0 node_id metric
# @genfunction "GET" esnodes_info NodesType{:_info} 0 node_id_metric
# @genfunction "GET" esnodes_info NodesType{:_info} 0
# @genfunction "GET" esnodes_hot_threads NodesType{:_hot_threads} 0 id
# @genfunction "GET" esnodes_hot_threads NodesType{:_hot_threads} 0


function es_nodes_info(info::Esinfo, node_id::AbstractString, metric::AbstractString ; kw...)

	query = Dict(kw...)
	url   = make_url(NodesType{:_info}, info, node_id, metric )
	@catexport info "GET"  url  query

end

function es_nodes_info(info::Esinfo, node_id_metric::AbstractString ;  kw...)

	query = Dict(kw...)
	url   = make_url(NodesType{:_info}, info, node_id_metric)
	@catexport info "GET"  url  query

end

function es_nodes_info(info::Esinfo ;  kw...)

	query = Dict(kw...)
	url   = make_url(NodesType{:_info}, info)
	@catexport info "GET"  url  query

end


function es_nodes_hot_threads(info::Esinfo, id::AbstractString ;  kw...)

	query = Dict(kw...)
	url   = make_url(NodesType{:_hot_threads}, info, node_id_metric)
	@catexport info "GET"  url  query

end

function es_nodes_hot_threads(info::Esinfo ;  kw...)

	query = Dict(kw...)
	url   = make_url(NodesType{:_hot_threads}, info)
	@catexport info "GET"  url  query

end

function es_indices_delete(info::Esinfo, index::AbstractString ; kw...)

	query = Dict(kw...)
	url   = make_url(IndicesType{:_delete}, info, index  )
	@esdelete(info ,url ,  Dict(kw...) )

end

function es_indices_delete_alias(info::Esinfo, index::AbstractString, name::AbstractString ; kw...)

	query = Dict(kw...)
	url   = make_url(IndicesType{:_delete_alias}, info, index ,name )
	@esdelete(info ,url ,  Dict(kw...) )

end

function es_indices_delete_template(info::Esinfo, name::AbstractString ; kw...)

	query = Dict(kw...)
	url   = make_url(IndicesType{:_delete_template}, info ,name )
	@esdelete(info ,url ,  Dict(kw...) )

end

function es_indices_exists(info::Esinfo, index::AbstractString ; kw...)

	url   = make_url(IndicesType{:_exists}, info, index)
	@eshead info  url   Dict(kw...)

end

function es_indices_exists_alias(info::Esinfo, name::AbstractString ; kw...)

	url   = make_url(IndicesType{:_exists_alias}, info, name)
	@eshead info  url   Dict(kw...)

end

function es_indices_exists_alias(info::Esinfo, index::AbstractString, name::AbstractString ; kw...)

	url   = make_url(IndicesType{:_exists_alias}, info, index,name)
	@eshead info  url   Dict(kw...)

end

function es_indices_exists_template(info::Esinfo, name::AbstractString ; kw...)

	url   = make_url(IndicesType{:_exists_template}, info ,name)
	@eshead info  url   Dict(kw...)

end

function es_indices_exists_type(info::Esinfo, index::AbstractString ,type::AbstractString ; kw...)

	url   = make_url(IndicesType{:_exists_type}, info ,index, type)
	@eshead info  url   Dict(kw...)

end
