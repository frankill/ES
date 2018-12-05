struct ClusterType{T} end
struct IndicesType{T} end
struct IngestType{T} end
struct NodesType{T} end
struct SnapshotType{T} end
struct TasksType{T} end

function makeurl(::Type{ClusterType{:_allocation_explain}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/allocation/explain"
end

function makeurl(::Type{ClusterType{:_get_settings}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/settings"
end

function makeurl(::Type{ClusterType{:_health}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/_cluster/health/$index"
end

function makeurl(::Type{ClusterType{:_health}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/health/"
end

function makeurl(::Type{ClusterType{:_pending_tasks}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/pending_tasks"
end

function makeurl(::Type{ClusterType{:_put_settings}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/settings"
end

function makeurl(::Type{ClusterType{:_remote_info}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_remote/info"
end

function makeurl(::Type{ClusterType{:_reroute}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/reroute"
end

function makeurl(::Type{ClusterType{:_state}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/state"
end

function makeurl(::Type{ClusterType{:_state}}, info::Esinfo, metric::AbstractString)
	"http://$(info.host):$(info.port)/_cluster/state/$metric"
end

function makeurl(::Type{ClusterType{:_state}}, info::Esinfo, metric::AbstractString, index::AbstractString)
	"http://$(info.host):$(info.port)/_cluster/state/$metric/$index"
end

function makeurl(::Type{ClusterType{:_stats}}, info::Esinfo, node_id::AbstractString)
	"http://$(info.host):$(info.port)/_cluster/stats/nodes/$node_id/"
end

function makeurl(::Type{ClusterType{:_stats}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cluster/stats"
end

function makeurl(::Type{IndicesType{:_analyze}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_analyze"
end

function makeurl(::Type{IndicesType{:_analyze}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_analyze"
end

function makeurl(::Type{IndicesType{:_clear_cache}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cache/clear"
end

function makeurl(::Type{IndicesType{:_clear_cache}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_cache/clear"
end

function makeurl(::Type{IndicesType{:_close}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_close"
end

function makeurl(::Type{IndicesType{:_create}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index"
end

function makeurl(::Type{IndicesType{:_delete}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index"
end
 
function makeurl(::Type{IndicesType{:_delete_alias}}, info::Esinfo, index::AbstractString, name::AbstractString)
	"http://$(info.host):$(info.port)/$index/_alias/$name"
end

function makeurl(::Type{IndicesType{:_delete_template}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/_template/$name"
end

function makeurl(::Type{IndicesType{:_exists}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index"
end

function makeurl(::Type{IndicesType{:_exists_alias}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/_alias/$name"
end

function makeurl(::Type{IndicesType{:_exists_alias}}, info::Esinfo, index::AbstractString,name::AbstractString)
	"http://$(info.host):$(info.port)/$index/_alias/$name"
end

function makeurl(::Type{IndicesType{:_exists_template}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/_template/$name"
end

function makeurl(::Type{IndicesType{:_exists_type}}, info::Esinfo, index::AbstractString, type::AbstractString)
	"http://$(info.host):$(info.port)/$index/_mapping/$type"
end

function makeurl(::Type{IndicesType{:_flush}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_flush"
end

function makeurl(::Type{IndicesType{:_flush}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_flush"
end

function makeurl(::Type{IndicesType{:_flush_synced}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_flush/synced"
end

function makeurl(::Type{IndicesType{:_forcemerge}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_forcemerge"
end

function makeurl(::Type{IndicesType{:_forcemerge}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_forcemerge"
end

function makeurl(::Type{IndicesType{:_get}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index"
end

function makeurl(::Type{IndicesType{:_get_alias}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_alias"
end

function makeurl(::Type{IndicesType{:_get_alias}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/_alias/$name"
end

function makeurl(::Type{IndicesType{:_get_alias}}, info::Esinfo, index::AbstractString, name::AbstractString)
	"http://$(info.host):$(info.port)/$index/_alias/$name"
end

function makeurl(::Type{IndicesType{:_get_field_mapping}}, info::Esinfo, fields::AbstractString)
	"http://$(info.host):$(info.port)/_mapping/field/$fields"
end

function makeurl(::Type{IndicesType{:_get_field_mapping}}, info::Esinfo, index::AbstractString, fields::AbstractString)
	"http://$(info.host):$(info.port)/$index/_mapping/field/$fields"
end

function makeurl(::Type{IndicesType{:_get_mapping}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_mapping"
end

function makeurl(::Type{IndicesType{:_get_mapping}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_mapping"
end

function makeurl(::Type{IndicesType{:_get_settings}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_settings"
end

function makeurl(::Type{IndicesType{:_get_settings}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_settings"
end

function makeurl(::Type{IndicesType{:_get_template}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/_template/$name"
end

function makeurl(::Type{IndicesType{:_get_template}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_template"
end

function makeurl(::Type{IndicesType{:_get_upgrade}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_upgrade"
end

function makeurl(::Type{IndicesType{:_get_upgrade}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_upgrade"
end

function makeurl(::Type{IndicesType{:_open}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_open"
end

function makeurl(::Type{IndicesType{:_put_alias}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_aliases"
end

function makeurl(::Type{IndicesType{:_put_alias}}, info::Esinfo ,index::AbstractString, name::AbstractString )
	"http://$(info.host):$(info.port)/$index/_alias/$name"
end

function makeurl(::Type{IndicesType{:_put_mapping}}, info::Esinfo ,index::AbstractString, type::AbstractString )
	"http://$(info.host):$(info.port)/$index/_mapping/$type"
end

function makeurl(::Type{IndicesType{:_put_mapping}}, info::Esinfo ,index::AbstractString  )
	"http://$(info.host):$(info.port)/$index"
end

function makeurl(::Type{IndicesType{:_put_settings}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_settings"
end

function makeurl(::Type{IndicesType{:_put_settings}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_settings"
end

function makeurl(::Type{IndicesType{:_put_template}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/_template/$name"
end

function makeurl(::Type{IndicesType{:_recovery}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_recovery"
end

function makeurl(::Type{IndicesType{:_recovery}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/$index/_recovery"
end

function makeurl(::Type{IndicesType{:_refresh}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/$index/_refresh"
end

function makeurl(::Type{IndicesType{:_refresh}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_refresh"
end

function makeurl(::Type{IndicesType{:_rollover}}, info::Esinfo, alias::AbstractString)
	"http://$(info.host):$(info.port)/$alias/_rollover"
end

function makeurl(::Type{IndicesType{:_rollover}}, info::Esinfo, alias::AbstractString, new_index::AbstractString)
	"http://$(info.host):$(info.port)/$alias/_rollover/$new_index"
end

function makeurl(::Type{IndicesType{:_segments}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_segments"
end

function makeurl(::Type{IndicesType{:_segments}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_segments"
end

function makeurl(::Type{IndicesType{:_shard_stores}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_shard_stores"
end

function makeurl(::Type{IndicesType{:_shard_stores}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_shard_stores"
end

function makeurl(::Type{IndicesType{:_shrink}}, info::Esinfo, index::AbstractString, target::AbstractString)
	"http://$(info.host):$(info.port)/$index/_shrink/$target"
end

function makeurl(::Type{IndicesType{:_split}}, info::Esinfo, index::AbstractString, target::AbstractString)
	"http://$(info.host):$(info.port)/$index/_split/$target"
end

function makeurl(::Type{IndicesType{:_stats}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_stats"
end

function makeurl(::Type{IndicesType{:_stats}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_stats"
end

function makeurl(::Type{IndicesType{:_update_aliases}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_aliases"
end

function makeurl(::Type{IndicesType{:_upgrade}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_upgrade"
end

function makeurl(::Type{IndicesType{:_upgrade}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_upgrade"
end

function makeurl(::Type{IndicesType{:_validate_query}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_validate/query"
end

function makeurl(::Type{IndicesType{:_validate_query}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_validate/query"
end

function makeurl(::Type{IngestType{:_delete_pipeline}}, info::Esinfo, id::AbstractString)
	"http://$(info.host):$(info.port)/_ingest/pipeline/$id"
end

function makeurl(::Type{IngestType{:_get_pipeline}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_ingest/pipeline"
end

function makeurl(::Type{IngestType{:_get_pipeline}}, info::Esinfo, id::AbstractString)
	"http://$(info.host):$(info.port)/_ingest/pipeline/$id"
end

function makeurl(::Type{IngestType{:_processor_grok}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_ingest/processor/grok"
end

function makeurl(::Type{IngestType{:_put_pipeline}}, info::Esinfo, id::AbstractString)
	"http://$(info.host):$(info.port)/_ingest/pipeline/$id"
end

function makeurl(::Type{IngestType{:_simulate}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_ingest/pipeline/_simulate"
end

function makeurl(::Type{IngestType{:_simulate}}, info::Esinfo, id::AbstractString)
	"http://$(info.host):$(info.port)/_ingest/pipeline/$id/_simulate"
end

function makeurl(::Type{NodesType{:_hot_threads}}, info::Esinfo, id::AbstractString)
	"http://$(info.host):$(info.port)/_nodes/$id/hot_threads"
end

function makeurl(::Type{NodesType{:_hot_threads}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_nodes/hot_threads"
end

function makeurl(::Type{NodesType{:_info}}, info::Esinfo, node_id_metric::AbstractString)
	"http://$(info.host):$(info.port)/_nodes/$node_id_metric"
end

function makeurl(::Type{NodesType{:_info}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_nodes/hot_threads"
end

function makeurl(::Type{NodesType{:_info}}, info::Esinfo, node_id::AbstractString, metric::AbstractString)
	"http://$(info.host):$(info.port)/_nodes/$node_id/$metric"
end

function makeurl(::Type{NodesType{:_reload_secure_settings}}, info::Esinfo, node_id::AbstractString)
	"http://$(info.host):$(info.port)/_nodes/$node_id/reload_secure_settings"
end

function makeurl(::Type{NodesType{:_reload_secure_settings}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_nodes/reload_secure_settings"
end

function makeurl(::Type{NodesType{:_usage}}, info::Esinfo, node_id::AbstractString)
	"http://$(info.host):$(info.port)/_nodes/$node_id/usage"
end

function makeurl(::Type{NodesType{:_usage}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_nodes/usage"
end

function makeurl(::Type{NodesType{:_stats}}, info::Esinfo, node_id::AbstractString)
	"http://$(info.host):$(info.port)/_nodes/$node_id/stats"
end

function makeurl(::Type{NodesType{:_stats}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_nodes/stats"
end

function makeurl(::Type{SnapshotType{:_snapshot}}, info::Esinfo, repository::AbstractString, snapshot::AbstractString)
	"http://$(info.host):$(info.port)/_snapshot/$repository/$snapshot"
end

function makeurl(::Type{SnapshotType{:_snapshot_repository}}, info::Esinfo, repository::AbstractString)
	"http://$(info.host):$(info.port)/_snapshot/$repository"
end

function makeurl(::Type{SnapshotType{:_get_repository}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_snapshot/"
end

function makeurl(::Type{SnapshotType{:_restore}}, info::Esinfo, repository::AbstractString, snapshot::AbstractString)
	"http://$(info.host):$(info.port)/_snapshot/$repository/$snapshot/_restore"
end

function makeurl(::Type{SnapshotType{:_status}}, info::Esinfo, repository::AbstractString, snapshot::AbstractString)
	"http://$(info.host):$(info.port)/_snapshot/$repository/$snapshot/_status"
end

function makeurl(::Type{SnapshotType{:_status}}, info::Esinfo, repository::AbstractString)
	"http://$(info.host):$(info.port)/_snapshot/$repository/_status"
end

function makeurl(::Type{SnapshotType{:_status}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_snapshot/_status"
end

function makeurl(::Type{SnapshotType{:_verify_repository}}, info::Esinfo, repository::AbstractString)
	"http://$(info.host):$(info.port)/_snapshot/$repository/_verify"
end

function makeurl(::Type{TasksType{:_list}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_tasks"
end

function makeurl(::Type{TasksType{:_get}}, info::Esinfo, task_id::AbstractString)
	"http://$(info.host):$(info.port)/_tasks/$task_id"
end

function makeurl(::Type{TasksType{:_cancel}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_tasks/_cancel"
end

function makeurl(::Type{TasksType{:_cancel}}, info::Esinfo, task_id::AbstractString)
	"http://$(info.host):$(info.port)/_tasks/$task_id/_cancel"
end

#task 
@genfunction "GET" es_tasks_cancel TasksType{:_cancel} 0 task_id
@genfunction "GET" es_tasks_cancel TasksType{:_cancel} 0  
@genfunction "GET" es_tasks_get TasksType{:_get} 0 task_id
@genfunction "POST" es_tasks_list TasksType{:_list} 0  

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
@genfunction "POST" es_indices_analyze IndicesType{:_analyze} 0 
@genfunction "POST" es_indices_analyze IndicesType{:_analyze} 0 index

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
	url   = makeurl(NodesType{:_info}, info, node_id, metric )
	@catexport "GET"  url  query 

end

function es_nodes_info(info::Esinfo, node_id_metric::AbstractString ;  kw...)

	query = Dict(kw...)
	url   = makeurl(NodesType{:_info}, info, node_id_metric)
	@catexport "GET"  url  query 

end

function es_nodes_info(info::Esinfo ;  kw...)

	query = Dict(kw...)
	url   = makeurl(NodesType{:_info}, info)
	@catexport "GET"  url  query 

end


function es_nodes_hot_threads(info::Esinfo, id::AbstractString ;  kw...)

	query = Dict(kw...)
	url   = makeurl(NodesType{:_hot_threads}, info, node_id_metric)
	@catexport "GET"  url  query 

end

function es_nodes_hot_threads(info::Esinfo ;  kw...)

	query = Dict(kw...)
	url   = makeurl(NodesType{:_hot_threads}, info)
	@catexport "GET"  url  query 

end

function es_indices_delete(info::Esinfo, index::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(IndicesType{:_delete}, info, index  )
	@esdelete(url ,  Dict(kw...) )

end

function es_indices_delete_alias(info::Esinfo, index::AbstractString, name::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(IndicesType{:_delete_alias}, info, index ,name )
	@esdelete(url ,  Dict(kw...) )

end

function es_indices_delete_template(info::Esinfo, name::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(IndicesType{:_delete_template}, info ,name )
	@esdelete(url ,  Dict(kw...) )

end

function es_indices_exists(info::Esinfo, index::AbstractString ; kw...)

	url   = makeurl(IndicesType{:_exists}, info, index)
	@eshead  url   Dict(kw...)  

end

function es_indices_exists_alias(info::Esinfo, name::AbstractString ; kw...)

	url   = makeurl(IndicesType{:_exists_alias}, info, name)
	@eshead  url   Dict(kw...)  

end

function es_indices_exists_alias(info::Esinfo, index::AbstractString, name::AbstractString ; kw...)

	url   = makeurl(IndicesType{:_exists_alias}, info, index,name)
	@eshead  url   Dict(kw...)  

end

function es_indices_exists_template(info::Esinfo, name::AbstractString ; kw...)

	url   = makeurl(IndicesType{:_exists_template}, info ,name)
	@eshead  url   Dict(kw...)  

end

function es_indices_exists_type(info::Esinfo, index::AbstractString ,type::AbstractString ; kw...)

	url   = makeurl(IndicesType{:_exists_type}, info ,index, type)
	@eshead  url   Dict(kw...)  

end

 
