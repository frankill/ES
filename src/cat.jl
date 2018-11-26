struct CatType{T} end

function makeurl(::Type{CatType{:_cat}}, info::Esinfo, name::AbstractString)
	"http://$(info.host):$(info.port)/_cat/aliases/$name"
end

function makeurl(::Type{CatType{:_cat}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cat/aliases"
end

function makeurl(::Type{CatType{:_allocation}}, info::Esinfo, node_id::AbstractString)
	"http://$(info.host):$(info.port)/_cat/allocation/$name"
end

function makeurl(::Type{CatType{:_allocation}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cat/allocation"
end

function makeurl(::Type{CatType{:_count}}, info::Esinfo, node_id::AbstractString)
	"http://$(info.host):$(info.port)/_cat/count/$name"
end

function makeurl(::Type{CatType{:_count}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_cat/count"
end

function esaliases(info::Esinfo, name::AbstractString ;kw...)

	query = Dict(kw...)
	url   = makeurl(CatType{:_cat}, info, name )
	@esexport "GET" url json(body) query "application/json"

end

function esaliases(info::Esinfo ;kw...)

	query = Dict(kw...)
	url   = makeurl(CatType{:_cat}, info )
	@esexport "GET" url json(body) query "application/json"

end

function esallocation(info::Esinfo, node_id::AbstractString ;kw...)

	query = Dict(kw...)
	url   = makeurl(CatType{:_allocation}, info, node_id )
	@esexport "GET" url json(body) query "application/json"

end

function esallocation(info::Esinfo ;kw...)

	query = Dict(kw...)
	url   = makeurl(CatType{:_allocation}, info )
	@esexport "GET" url json(body) query "application/json"

end

function escatcount(info::Esinfo, index::AbstractString ;kw...)

	query = Dict(kw...)
	url   = makeurl(CatType{:_count}, info, node_id )
	@esexport "GET" url json(body) query "application/json"

end

function escatcount(info::Esinfo ;kw...)

	query = Dict(kw...)
	url   = makeurl(CatType{:_count}, info )
	@esexport "GET" url json(body) query "application/json"

end
