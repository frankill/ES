
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
	return esc(quote 
		function $(funname)(info::Esinfo, essql::T ; kw...) where T <: Union{Dict, AbstractString}
			querys = Dict(kw...) 
			isa(essql, Dict) && (essql = json(essql)) 
			url   = makeurl(Xpack($iname), info) 
			@esexport "POST" url essql querys "application/json"
		end 
	end) 
end 

@xpackfun "translate" 
@xpackfun "sql" 

