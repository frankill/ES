
struct Xpack{T} end

function makeurl(::Type{Xpack{:sql}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/"
end

function makeurl(::Type{Xpack{:translate}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/translate"
end

function Base.merge(a::AbstractString, b::AbstractString)
	endswith(a, b) && return a 
	join([a,b])
end  

macro xpackfun(interface) 
	iname = esc(Symbol(interface)) 
	funname = merge("xpack", interface ) 
	return quote 
		function ($funname)(info::Esinfo, sql::T; kw...) where T <: Union{AbstractString,Dict}
			query = Dict(kw...) 
			isa(sql, Dict) && sql = json(sql) 
			@esexport "POST" makeurl(Xpack{$(iname)}, info) sql query "application/json"
		end 
	end 
end 

@xpackfun "translate" 
@xpackfun "sql" 

