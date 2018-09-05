# 对es中常用的操作做了一些转换，支持must must_not filter nested 等过滤和查询
# in == terms
# =  == term
# has == exists
# ><  == gt lt 

```
using ES
using JSON
```

```julia
@fulltext(match = @query(type = "test")) |> json |> println 
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
@fulltext(match = @query(type = "test"), bool = @filter(has("openid"))) |> json |> println
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
@query(size = 1000, @filter(has("openid"))) |> json |> println
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
@query(size = 1000, query = @filter(has("openid"))) |> json |> println
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
path = :(path="/home")
@query( @nested(size=1000, path, @must( has("id")) , @filter(1< rownum <=100) ))
```
```json
{
	"query": {
		"bool": {
			"nested": {
				"path": "/home",
				"filter": [{
					"range": {
						"rownum": {
							"lte": 100,
							"gt": 1
						}
					}
				}],
				"size": 1000,
				"must": [{
					"exists": {
						"field": "id"
					}
				}]
			}
		}
	}
}
```
