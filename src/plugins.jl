
struct Xpack{T} end
Xpack(T) = Xpack{T}

function makeurl(::Type{Xpack{:_sql}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/"
end

function makeurl(::Type{Xpack{:_translate}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/translate"
end

function makeurl(::Type{Xpack{:_sql_close}}, info::Esinfo)
	"http://$(info.host):$(info.port)/_xpack/sql/close"
end

@genfunction "POST" xpack_sql Xpack{:_sql} 1
@genfunction "POST" xpack_sql_close Xpack{:_sql_close} 1
@genfunction "POST" xpack_translate Xpack{:_translate} 1
