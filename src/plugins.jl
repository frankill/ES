
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

macro xpackfun(interface, d) 
	iname = esc(Symbol(interface)) 
	funname = merge("xpacksql", interface ) 
	return quote 
		if isa($d, Dict)  
			function $(funname)(info::Esinfo, sql::Dict; kw...)  
				query = Dict(kw...) 
				@esexport "POST" makeurl(Xpack{$(iname)}, info) json(sql) query "application/json"
			end 
		else 
			function $(funname)(info::Esinfo, sql::AbstractString ; kw...)  
				query = Dict(kw...) 
				@esexport "POST" makeurl(Xpack{$(iname)}, info) sql query "application/json"
			end 
		end 
	end 
end 

@xpackfun "translate" Dict
@xpackfun "translate" AbstractString
@xpackfun "sql" Dict
@xpackfun "sql" AbstractString
