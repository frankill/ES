
struct Xpack{T} end

function makeurl(::Type{Xpack{:sql}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/"
end

function makeurl(::Type{Xpack{:translate}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/translate"
end

function essql(info::Esinfo, sql::AbstractString ; kw...)

	query = Dict(kw...) 
	@esexport "POST" makeurl(Xpack{:sql}, info) sql query "application/json"

end

function essql(info::Esinfo, sql::Dict ; kw...)

	query = Dict(kw...) 
	@esexport "POST" makeurl(Xpack{:sql}, info) json(sql) query "application/json"

end

function essql(info::Esinfo, sql::AbstractString ; kw...)

	query = Dict(kw...) 
	@esexport "POST" makeurl(Xpack{:translate}, info) sql query "application/json"

end

function essql(info::Esinfo, sql::Dict ; kw...)

	query = Dict(kw...) 
	@esexport "POST" makeurl(Xpack{:translate}, info) json(sql) query "application/json"

end
