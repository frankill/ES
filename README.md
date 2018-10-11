# Elasticsearch
 
es Client implemented in Julia.
I wanted something with which to learn a little Julia
So really this is just a pet project. I'm not sure how far it will get.
274510919@qq.com
 
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
```julia
@fulltext(size=1 , bool= @smi(minimum_should_match=1, 
							@filter(1<c <=3 , has("Ta"), h % "ks", ff * "s.*?y"),  
							@should(@must_not(a=1), @must(b=2)) ) )
```
```json
{
    "query": {
        "size": 1,
        "bool": {
            "minimum_should_match": 1,
            "filter": [
                {
                    "range": {
                        "c": {
                            "lte": 3,
                            "gt": 1
                        }
                    }
                },
                {
                    "exists": {
                        "field": "Ta"
                    }
                },
                {
                    "wildcard": {
                        "h": "ks"
                    }
                },
                {
                    "regexp": {
                        "ff": "s.*?y"
                    }
                }
            ],
            "should": [
                {
                    "bool": {
                        "must_not": [
                            {
                                "term": {
                                    "a": 1
                                }
                            }
                        ]
                    }
                },
                {
                    "bool": {
                        "must": [
                            {
                                "term": {
                                    "b": 2
                                }
                            }
                        ]
                    }
                }
            ]
        }
    }
}
```

```julia
using BenchmarkTools

@btime @fulltext(size=1 , bool= @smi(minimum_should_match=1,  @filter(1<c <=3 , has("Ta"), h % "ks", ff * "s.*?y") 
,@should(@must_not(a=1), @must(b=2)) ) )
```
```text
  38.100 μs (186 allocations: 15.97 KiB)
Dict{String,Dict{String,Any}} with 1 entry:
  "query" => Dict{String,Any}("size"=>1,"bool"=>Dict{String,Any}("minimum_should_match"=>1,"filter"=>Pair{String,Dict{String,V} where V}["…
```

```julia
@query(  size=1 , 
	 query= @smi(bool= @smi(minimum_should_match=1, 
				@filter(1<c <=3 , 
					has("Ta"), 
					h % "ks", 
					ff * "s.*?y"),  
				@should(
					@must_not(a=1), 
					@must(b=2)) )) ,
	aggs= @smi(t= @smi(a=123)))
```
```json 
{
    "aggs": {
        "t": {
            "a": 123
        }
    },
    "size": 1,
    "query": {
        "bool": {
            "minimum_should_match": 1,
            "filter": [
                {
                    "range": {
                        "c": {
                            "lte": 3,
                            "gt": 1
                        }
                    }
                },
                {
                    "exists": {
                        "field": "Ta"
                    }
                },
                {
                    "wildcard": {
                        "h": "ks"
                    }
                },
                {
                    "regexp": {
                        "ff": "s.*?y"
                    }
                }
            ],
            "should": [
                {
                    "bool": {
                        "must_not": [
                            {
                                "term": {
                                    "a": 1
                                }
                            }
                        ]
                    }
                },
                {
                    "bool": {
                        "must": [
                            {
                                "term": {
                                    "b": 2
                                }
                            }
                        ]
                    }
                }
            ]
        }
    }
}
```
