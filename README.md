# in == terms
# =  == term
# has == exists
# ><  == gt lt 

```julia
julia > @fulltext(match = @query(type = "test")) | > json | > println 
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

julia > @fulltext(match = @query(type = "test"), bool = @filter(has("openid"))) | > json | > println

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


julia > @query(size = 1000, @filter(has("openid"))) | > json | > println

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

julia > @query(size = 1000, query = @filter(has("openid"))) | > json | > println

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


