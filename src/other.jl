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

function esdeletebyqueryrethrottle(info::Esinfo, task_id::AbstractString  ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_delete_rethrottle}, info, task_id  )
	@esexport "POST" url Dict() query "application/json"

end

function esdeletebyquery(info::Esinfo, scripts_id::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_delete_script}, info, scripts_id  )
	HTTP.delete(url , query= Dict(kw...) )

end

function esdeletebyquery(info::Esinfo, index::AbstractString, type::AbstractString, dsl::Dict ; kw...)

 	esdeletebyquery(info, "$index/$type", json(dsl), kw...)

end

function esdeletebyquery(info::Esinfo, index::AbstractString, type::AbstractString, dsl::AbstractString ; kw...)

 	esdeletebyquery(info, "$index/$type", dsl, kw...)

end

function esdeletebyquery(info::Esinfo, index::AbstractString, dsl::Dict ; kw...)

 	esdeletebyquery(info, index, json(dsl), kw...)

end

function esdeletebyquery(info::Esinfo, index::AbstractString, dsl::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_delete}, info, index  )
	@esexport "POST" url dsl query "application/json"

end

function esexists(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

	url   = makeurl(DmlType{:_head}, info, index ,type, id )
	HTTP.head(url , query= Dict(kw...) )

end

function esexistssource(info::Esinfo, index::AbstractString, type::AbstractString, id::AbstractString ; kw...)

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

function esfieldcaps(info::Esinfo, index::AbstractString ; kw...)

	query = Dict(kw...)
	url   = makeurl(DdlType{:_field_caps}, info, index  )
	@esexport "POST" url Dict() query "application/json"

end

function esfieldcaps(info::Esinfo  ; kw...)

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



function escreate(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::Dict; kw...)

	escreate(info, index, type, id, json(doc), kw...)

end

function escreate(info::Esinfo, index::AbstractString, type::AbstractString,id::AbstractString, doc::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DmlType{:_index}, info, index ,type, id )
	@esexport "POST" url doc query "application/json"

end

function escreate(info::Esinfo, index::AbstractString, type::AbstractString, doc::Dict; kw...)

	escreate(info, index, type, json(doc), kw...)

end

function escreate(info::Esinfo, index::AbstractString, type::AbstractString, doc::AbstractString; kw...)

	query = Dict(kw...)
	url   = makeurl(DmlType{:_index}, info, index ,type )
	@esexport "POST" url doc query "application/json"

end

