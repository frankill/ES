
struct Xpack{T} end
Xpack(T) = Xpack{T}

function makeurl(::Type{Xpack{:sql}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/"
end

function makeurl(::Type{Xpack{:translate}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/translate"
end

@genfunction "POST" xpacksql Xpack{:sql} 1
@genfunction "POST" xpacktranslate Xpack{:translate} 1
