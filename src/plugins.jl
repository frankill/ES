
struct Xpack{T} end

function makeurl(::Type{Xpack{:sql}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/"
end

function makeurl(::Type{Xpack{:translate}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/translate"
end

macro xpackfun(interface, d) 
	funcname = esc(Symbol(interface)) 
	return quote 
		function $(funcname)(info::Esinfo, sql::$d ; kw...)  
			query = Dict(kw...) 
			@esexport "POST" makeurl(Xpack{:translate}, info) json(sql) query "application/json"
		end 
	end 
end 

@xpackfun "essqltrans" Dict
@xpackfun "essqltrans" AbstractString
@xpackfun "essql" Dict
@xpackfun "essql" AbstractString
