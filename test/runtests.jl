@fulltext(match = @query(type = "test")) 
@fulltext(match = @query(type = "test"), bool = @filter(has("openid")))
@query(size = 1000, @filter(has("openid")))
@query(size = 1000, query = @filter(has("openid")))

a = :( 1< a <=4)
@query(a)
