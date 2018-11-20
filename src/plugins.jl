
struct Xpack{T} end
Xpack(T) = Xpack{T}

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
	funname = esc(Symbol(merge("xpack", interface )) )
	return quote 
		function $(funname)(info::Esinfo, sql::T; kw...) where T <: Union{AbstractString,Dict}
			query = Dict(kw...) 
			isa(sql, Dict) && (sql = json(sql)) 
			url   = makeurl(Xpack($iname), info) 
			print(url)
			@esexport "POST" url sql query "application/json"
		end 
	end 
end 

@xpackfun "translate" 
@xpackfun "sql" 

