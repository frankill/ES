# Elasticsearch
 
es Client implemented in Julia.
I wanted something with which to learn a little Julia
So really this is just a pet project. I'm not sure how far it will get.
 
``` julia
using ES

"""
in == terms
=  == term
has == exists
><  == gt lt 
"""
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
sizes , rownum = 1000, 100
@query(size=sizes,_source in ["a","b"], @must_not(id >100) , @nested( path="home", @query(@filter(1< home.rownum <=rownum) )))
```
```json
{
	"size": 1000,
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
									"lte": 100000,
									"gt": 1
								}
							}
						}]
					}
				},
				"path": "home"
			}
		}
	},
	"_source": ["a", "b"]
}
```
