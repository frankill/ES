# 对es中常用的操作做了一些转换，支持must must_not filter nested 等过滤和查询
# in == terms
# =  == term
# has == exists
# ><  == gt lt 
# julia对应到es中的json
```
using ES
using JSON
```

```julia
@fulltext(match = @query(type = "test")) 
```
```json
{
	"query": {
		"match": {
			"type": "test"
		}
	}
}
```
```julia
@fulltext(match = @query(type = "test"), bool = @filter(has("openid")))
```
```json
{
	"query": {
		"bool": {
			"filter": [{
				"exists": {
					"field": "openid"
				}
			}]
		},
		"match": {
			"type": "test"
		}
	}
}
```
```julia
@query(size = 1000, @filter(has("openid"))) 
```
```json
{
	"size": 1000,
	"query": {
		"bool": {
			"filter": [{
				"exists": {
					"field": "openid"
				}
			}]
		}
	}
}
```
```julia
@query(size = 1000, query = @filter(has("openid"))) 
```
```json
{
	"size": 1000,
	"query": {
		"bool": {
			"filter": [{
				"exists": {
					"field": "openid"
				}
			}]
		}
	}
}
```

```julia
@query(size=100, @must_not(id >100) , @nested( path="home", @query(@filter(1< home.rownum <=100) )))
```
```json
{
	"size": 100,
	"query": {
		"bool": {
			"must_not": [{
				"range": {
					"id": {
						"gt": 100
					}
				}
			}],
			"nested": {
				"query": {
					"bool": {
						"filter": [{
							"range": {
								"home.rownum": {
									"lte": 100,
									"gt": 1
								}
							}
						}]
					}
				},
				"path": "home"
			}
		}
	}
}
```
