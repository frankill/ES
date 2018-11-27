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

function makeurl(::Type{DdlType{:_update}}, info::Esinfo, index::AbstractString )
	"http://$(info.host):$(info.port)/$index/_update_by_query"
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

function makeurl(::Type{DdlType{:search_shards}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_search_shards"
end

function makeurl(::Type{DdlType{:search_shards}}, info::Esinfo, index::AbstractString)
	"http://$(info.host):$(info.port)/$index/_search_shards"
end

function escreate(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::Dict; kw...)

	escreate(info, index, type, id, json(doc), kw...)

end

function escreate(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DmlType{:_create}, info, index ,type, id )
	@esexport "POST" url doc query "application/json"

end

function esdelete(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString ; kw...)

	url   = makeurl(DmlType{:_delete}, info, index ,type, id )
	HTTP.delete(url , query= Dict(kw...) )

end

function esdelete_by_query_rethrottle(info::Esinfo, task_id::AbstractString  ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_delete_rethrottle}, info, task_id  )
	@esexport "POST" url Dict() query "application/json"

end

function esupdate_by_query_rethrottle(info::Esinfo, task_id::AbstractString  ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_update_rethrottle}, info, task_id  )
	@esexport "POST" url Dict() query "application/json"

end

function esdelete_by_query(info::Esinfo, scripts_id::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_delete_script}, info, scripts_id  )
	HTTP.delete(url , query= Dict(kw...) )

end

function esdelete_by_query(info::Esinfo, index::AbstractString, type::AbstractString, dsl::Dict ; kw...)

 	esdelete_by_query(info, "$index/$type", json(dsl), kw...)

end

function esdelete_by_query(info::Esinfo, index::AbstractString, type::AbstractString, dsl::AbstractString ; kw...)

 	esdelete_by_query(info, "$index/$type", dsl, kw...)

end

function esdelete_by_query(info::Esinfo, index::AbstractString, dsl::Dict ; kw...)

 	esdelete_by_query(info, index, json(dsl), kw...)

end

function esdelete_by_query(info::Esinfo, index::AbstractString, dsl::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_delete}, info, index  )
	@esexport "POST" url dsl query "application/json"

end

function esupdate_by_query(info::Esinfo, index::AbstractString, type::AbstractString, dsl::Dict ; kw...)

 	esupdate_by_query(info, "$index/$type", json(dsl), kw...)

end

function esupdate_by_query(info::Esinfo, index::AbstractString, type::AbstractString, dsl::AbstractString ; kw...)

 	esupdate_by_query(info, "$index/$type", dsl, kw...)

end

function esupdate_by_query(info::Esinfo, index::AbstractString, dsl::Dict ; kw...)

 	esupdate_by_query(info, index, json(dsl), kw...)

end

function esupdate_by_query(info::Esinfo, index::AbstractString, dsl::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_update}, info, index  )
	@esexport "POST" url dsl query "application/json"

end

function esexists(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

	url   = makeurl(DmlType{:_head}, info, index ,type, id )
	HTTP.head(url , query= Dict(kw...) )

end

function esexists_source(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

	esexists(info, index ,type, "$id/_source" , kw...)

end


function esexplain(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString, dsl::Dict ; kw...)

 	esexplain(info, index, type, id,  json(dsl), kw...)

end

function esexplain(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString, dsl::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_explain}, info, index  )
	@esexport "POST" url dsl query "application/json"

end

function esfield_caps(info::Esinfo, index::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_field_caps}, info, index  )
	@esexport "POST" url Dict() query "application/json"

end

function esfield_caps(info::Esinfo  ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_field_caps}, info )
	@esexport "POST" url Dict() query "application/json"

end

function esget(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

 	query = Dict(kw...)
	url   = makeurl(DmlType{:_get}, info ,index, type, id  )
	@esexport "GET" url Dict() query "application/json"

end

function esgetscript(info::Esinfo, scripts_id::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_get_script}, info, scripts_id  )
	@esexport "GET" url Dict() query "application/json"

end

function esgetsource(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

 	query = Dict(kw...)
	url   = makeurl(DmlType{:_get_source}, info ,index, type, id  )
	@esexport "GET" url Dict() query "application/json"

end

function esindex(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::Dict; kw...)

	esindex(info, index, type, id, json(doc), kw...)

end

function esindex(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DmlType{:_index}, info, index ,type, id )
	@esexport "POST" url doc query "application/json"

end

function esindex(info::Esinfo, index::AbstractString, type::AbstractString, doc::Dict; kw...)

	esindex(info, index, type, json(doc), kw...)

end

function esindex(info::Esinfo, index::AbstractString, type::AbstractString, doc::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DmlType{:_index}, info, index ,type )
	@esexport "POST" url doc query "application/json"

end

function esupdate(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::Dict; kw...)

	esupdate(info, index, type, id, json(doc), kw...)

end

function esupdate(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DmlType{:_update}, info, index ,type, id )
	@esexport "POST" url doc query "application/json"

end

function esmget(info::Esinfo, index::AbstractString, type::AbstractString, body::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_mget}, info, index ,type )
	@esexport "POST" url body query "application/json"

end

function esmget(info::Esinfo, index::AbstractString, type::AbstractString, body::AbstractString; kw...)

	esmget(info, index, type, json(body), kw...)

end

function esmget(info::Esinfo, index::AbstractString, body::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_mget}, info, index  )
	@esexport "POST" url body query "application/json"

end

function esmget(info::Esinfo, index::AbstractString, body::Dict; kw...)

	esmget(info, index, json(body), kw...)

end

function esmget(info::Esinfo, body::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_mget}, info )
	@esexport "POST" url body query "application/json"

end

function esmget(info::Esinfo, body::Dict; kw...)

	esmget(info, json(body), kw...)

end

function esmtermvectors(info::Esinfo, index::AbstractString, type::AbstractString, body::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_mtermvectors}, info, index ,type )
	@esexport "POST" url body query "application/json"

end

function esmtermvectors(info::Esinfo, index::AbstractString, type::AbstractString, body::Dict; kw...)

	esmtermvectors(info, index, type, json(body), kw...)

end

function esmtermvectors(info::Esinfo, index::AbstractString, body::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_mtermvectors}, info, index  )
	@esexport "POST" url body query "application/json"

end

function esmtermvectors(info::Esinfo, index::AbstractString, body::Dict; kw...)

	esmtermvectors(info, index, json(body), kw...)

end

function esmtermvectors(info::Esinfo, body::Dict; kw...)

	esmtermvectors(info, json(body), kw...)

end

function esmtermvectors(info::Esinfo, body::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_mtermvectors}, info )
	@esexport "POST" url body query "application/json"

end

function esping(info::Esinfo )

	url   = makeurl(DdlType{:_ping}, info )
	HTTP.head(url , query= Dict(kw...) )

end

function esputscript(info::Esinfo, scripts_id::AbstractString , body::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_put_script}, info, scripts_id  )
	@esexport "PUT" url body query "application/json"

end

function esputscript(info::Esinfo, scripts_id::AbstractString , body::Dict ; kw...)

	esputscript(info, scripts_id, json(body), kw...)

end

function esputscript(info::Esinfo, scripts_id::AbstractString , context::AbstractString ,body::Dict ; kw...)

	esputscript(info, scripts_id, context, json(body), kw...)

end

function esputscript(info::Esinfo, scripts_id::AbstractString , context::AbstractString ,body::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_put_script}, info, scripts_id ,context )
	@esexport "PUT" url body query "application/json"

end


function esrankeval(info::Esinfo, index::AbstractString , body::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_rank_eval}, info, index  )
	@esexport "PUT" url body query "application/json"

end

function esrankeval(info::Esinfo, index::AbstractString , body::Dict ; kw...)

	esrankeval(info, index, json(body), kw...)

end

function esrankeval(info::Esinfo , body::Dict ; kw...)

	esrankeval(info, json(body), kw...)

end

function esrankeval(info::Esinfo , body::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_rank_eval}, info  )
	@esexport "PUT" url body query "application/json"

end

function esreindex(info::Esinfo , dsl::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_reindex}, info  )
	@esexport "POST" url dsl query "application/json"

end

function esreindex(info::Esinfo , dsl::Dict ; kw...)

	esreindex(info, json(dsl), kw...)

end

function esreindex_rethrottle(info::Esinfo , task_id::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_reindex_rethrottle}, info , task_id )
	@esexport "POST" url Dict() query "application/json"

end


function esrender_search_template(info::Esinfo , id::AbstractString , body::AbstractString )

	url   = makeurl(DdlType{:_reindex_rethrottle}, info , id )
	@esexport "POST" url body Dict() "application/json"

end

function esrender_search_template(info::Esinfo , id::AbstractString , body::Dict )

	esrender_search_template(info, id, json(Dict))

end

function esrender_search_template(info::Esinfo ,body::Dict )

	esrender_search_template(info, json(Dict))

end

function esrender_search_template(info::Esinfo ,body::AbstractString )

	url   = makeurl(DdlType{:_reindex_rethrottle}, info )
	@esexport "POST" url body Dict() "application/json"

end

function esscripts_painless_execute(info::Esinfo ,body::AbstractString )

	url   = makeurl(DdlType{:_reindex_rethrottle}, info )
	@esexport "POST" url body Dict() "application/json"

end

function esscripts_painless_execute(info::Esinfo ,body::Dict )

	esscripts_painless_execute(info, json(body))

end

function essearch_shards(info::Esinfo , index::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_search_shards}, info , task_id )
	@esexport "POST" url Dict() query "application/json"

end

function essearch_shards(info::Esinfo   ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_search_shards}, info   )
	@esexport "POST" url Dict() query "application/json"

end
