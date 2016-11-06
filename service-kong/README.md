### Kong [site](https://getkong.org/) && [docs](https://getkong.org/docs/) 
  OpenSource API gateway and micro-service management layer, 
  delivering high performance and reliability.
  



## Get Start
 
```
# add own API on kong
curl -i -X POST \
  --url http://localhost:8001/apis/ \
  --data 'request_host=test.com' \
  --data 'upstream_url=http://mockbin.com'

# add plugins on the API
curl -i -X POST \
  --url http://localhost:8001/apis/test.com/plugins/ \
  --data 'name=rate-limiting' \
  --data 'config.minute=100'

# make a request
curl -i -X GET \
  --url http://localhost:8000/ \
  --header 'Host: test.com'  


```

