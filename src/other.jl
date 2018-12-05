struct DmlType{T} end
struct DdlType{T} end

function makeurl(::Type{DmlType{:_index}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id"
end

function makeurl(::Type{DmlType{:_index}}, info::Esinfo, index::AbstractString, type::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type"
end

function makeurl(::Type{DmlType{:_create}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id/_create"
end

function makeurl(::Type{DmlType{:_update}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id/_update"
end

function makeurl(::Type{DmlType{:_delete}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id"
end

function makeurl(::Type{DmlType{:_head}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id"
end

function makeurl(::Type{DmlType{:_get}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id"
end

function makeurl(::Type{DmlType{:_get_source}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id/_source"
end

function makeurl(::Type{DdlType{:_explain}}, info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/$id/_explain"
end

function makeurl(::Type{DdlType{:_delete}}, info::Esinfo, index::AbstractString )
	"http://$(info.host):$(info.port)/$index/_delete_by_query"
end

function makeurl(::Type{DdlType{:_delete}}, info::Esinfo, index::AbstractString , type::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/_delete_by_query"
end

function makeurl(::Type{DdlType{:_update}}, info::Esinfo, index::AbstractString )
	"http://$(info.host):$(info.port)/$index/_update_by_query"
end

function makeurl(::Type{DdlType{:_update}}, info::Esinfo, index::AbstractString , type::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/_update_by_query"
end

function makeurl(::Type{DdlType{:_delete_script}}, info::Esinfo, id::AbstractString )
	"http://$(info.host):$(info.port)/_scripts/$id"
end

function makeurl(::Type{DdlType{:_get_script}}, info::Esinfo, id::AbstractString )
	"http://$(info.host):$(info.port)/_scripts/$id"
end

function makeurl(::Type{DdlType{:_field_caps}}, info::Esinfo, index::AbstractString )
	"http://$(info.host):$(info.port)/$index/_field_caps"
end

function makeurl(::Type{DdlType{:_field_caps}}, info::Esinfo  )
	"http://$(info.host):$(info.port)/_field_caps"
end

function makeurl(::Type{DdlType{:_delete_rethrottle}}, info::Esinfo, task_id::AbstractString )
	"http://$(info.host):$(info.port)/_delete_by_query/$task_id/_rethrottle"
end

function makeurl(::Type{DdlType{:_update_rethrottle}}, info::Esinfo, task_id::AbstractString )
	"http://$(info.host):$(info.port)/_update_by_query/$task_id/_rethrottle"
end

function makeurl(::Type{DdlType{:_mget}}, info::Esinfo  )
	"http://$(info.host):$(info.port)/_mget"
end

function makeurl(::Type{DdlType{:_mget}}, info::Esinfo, index::AbstractString )
	"http://$(info.host):$(info.port)/$index/_mget"
end

function makeurl(::Type{DdlType{:_mget}}, info::Esinfo, index::AbstractString , type::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/_mget"
end


function makeurl(::Type{DdlType{:_mtermvectors}}, info::Esinfo  )
	"http://$(info.host):$(info.port)/_mtermvectors"
end

function makeurl(::Type{DdlType{:_mtermvectors}}, info::Esinfo, index::AbstractString )
	"http://$(info.host):$(info.port)/$index/_mtermvectors"
end

function makeurl(::Type{DdlType{:_mtermvectors}}, info::Esinfo, index::AbstractString , type::AbstractString)
	"http://$(info.host):$(info.port)/$index/$type/_mtermvectors"
end

function makeurl(::Type{DdlType{:_ping}}, info::Esinfo)
	"http://$(info.host):$(info.port)/"
end

function makeurl(::Type{DdlType{:_put_script}}, info::Esinfo, id::AbstractString )
	"http://$(info.host):$(info.port)/_scripts/$id"
end

function makeurl(::Type{DdlType{:_put_script}}, info::Esinfo, id::AbstractString, context::AbstractString )
	"http://$(info.host):$(info.port)/_scripts/$id/$context"
end

function makeurl(::Type{DdlType{:_rank_eval}}, info::Esinfo, index::AbstractString )
	"http://$(info.host):$(info.port)/_index/_rank_eval"
end

function makeurl(::Type{DdlType{:_rank_eval}}, info::Esinfo )
	"http://$(info.host):$(info.port)/_rank_eval"
end

function makeurl(::Type{DdlType{:_reindex}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_reindex"
end

function makeurl(::Type{DdlType{:_reindex_rethrottle}}, info::Esinfo, task_id::AbstractString )
	"http://$(info.host):$(info.port)/_reindex/$task_id/_rethrottle"
end

function makeurl(::Type{DdlType{:_render_search_template}}, info::Esinfo, id::AbstractString )
	"http://$(info.host):$(info.port)/_render/template/$id"
end

function makeurl(::Type{DdlType{:_render_search_template}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_render/template"
end

function makeurl(::Type{DdlType{:_scripts_painless_execute}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_scripts/painless/_execute"
end

function makeurl(::Type{DdlType{:_search_shards}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_search_shards"
end

function makeurl(::Type{DdlType{:_search_shards}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_search_shards"
end


function es_delete(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString ; kw...)

	url   = makeurl(DmlType{:_delete}, info, index ,type, id )
	@esdelete(url ,  Dict(kw...) )

end


function es_delete_by_query(info::Esinfo, scripts_id::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_delete_script}, info, scripts_id  )
	@esdelete(url ,  Dict(kw...) )

end

function es_exists(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

	url   = makeurl(DmlType{:_head}, info, index ,type, id )
	@eshead  url   Dict(kw...)  

end

function es_exists_source(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

	esexists(info, index ,type, "$id/_source"  ; kw...)

end

function es_ping(info::Esinfo )

	url   = makeurl(DdlType{:_ping}, info )
	@eshead  url  Dict()  

end


@genfunction "POST" es_create DmlType{:_create} 1 index, type, id
@genfunction "POST" es_delete_by_query_rethrottle DdlType{:_delete_rethrottle} 0 task_id
@genfunction "POST" es_update_by_query_rethrottle DdlType{:_update_rethrottle} 0 task_id
@genfunction "POST" es_delete_by_query DdlType{:_delete} 1 index type 
@genfunction "POST" es_delete_by_query DdlType{:_delete} 1 index 
@genfunction "POST" es_update_by_query DdlType{:_update} 1 index type 
@genfunction "POST" es_update_by_query DdlType{:_update} 1 index 
@genfunction "POST" es_explain DdlType{:_explain} 1 index type id
@genfunction "POST" es_field_caps DdlType{:_field_caps} 0 index
@genfunction "POST" es_field_caps DdlType{:_field_caps} 0
@genfunction "GET" es_get DmlType{:_get} 0 index type id 
@genfunction "GET" es_getscript DdlType{:_get_script} 0 scripts_id
@genfunction "GET" es_getsource DmlType{:_get_source} 0 index type id 
@genfunction "POST" es_index DmlType{:_index} 1 index type id 
@genfunction "POST" es_index DmlType{:_index} 1 index type 
@genfunction "POST" es_update DmlType{:_update} 1 index type id 
@genfunction "POST" es_update DdlType{:_mget} 1 index type  
@genfunction "POST" es_update DdlType{:_mget} 1 index  
@genfunction "POST" es_update DdlType{:_mget} 1 
@genfunction "POST" es_mtermvectors DdlType{:_mtermvectors} 1 index type 
@genfunction "POST" es_mtermvectors DdlType{:_mtermvectors} 1 index 
@genfunction "POST" es_mtermvectors DdlType{:_mtermvectors} 1 
@genfunction "PUT" es_put_script DdlType{:_put_script} 1 scripts_id context 
@genfunction "PUT" es_put_script DdlType{:_put_script} 1 scripts_id 
@genfunction "PUT" es_rank_eval DdlType{:_rank_eval} 1 index 
@genfunction "PUT" es_rank_eval DdlType{:_rank_eval} 1 
@genfunction "POST" es_reindex DdlType{:_reindex} 1 
@genfunction "POST" es_reindex_rethrottle DdlType{:_reindex_rethrottle} 0 task_id 
@genfunction "POST" es_render_search_template DdlType{:_render_search_template} 1 id 
@genfunction "POST" es_render_search_template DdlType{:_render_search_template} 1 
@genfunction "POST" es_scripts_painless_execute DdlType{:_scripts_painless_execute} 1 
@genfunction "POST" es_search_shards DdlType{:_search_shards} 0 index 
@genfunction "POST" es_search_shards DdlType{:_search_shards} 0 

