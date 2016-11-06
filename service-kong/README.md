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

## Code Snippets

```
# register service api
curl    -X POST <KONG_IP:KONG_PORT>/apis \
        --data 'name=<SERVICE_NAME>.<SERVICE_VERSION>' \
        --data 'upstream_url=<SERVICE_HOST>' \
        --data 'request_path=<SERVICE_URI>'


# activate plugins
http POST :8001/apis/<SERVICE_NAME>.<SERVICE_VERSION>/plugins \
    name=<PLUGIN_NAME> \
    config.<KEY>=<VALUE> 

# PLUGGIN_NAME : [loggly|rate-limiting|cors|galileo|ssl|oauth2]
#    * loggly        : [key=SECRET]
#    * rate-limiting : [hour=100 minutes=100]
#    * cors          : [origin=* methods=GET,PUT] 
#    * galileo       : [service_token=SECRET]
#    * ssl           : [cert=@/path/to/cert.pem key=@/path/to/cert.key]
#    * oauth2        : [scopes=x,y,z mandaatory_scope=true]
    
    
    
    


```


## Acronyms

* URI: Uniform Resource Identifier (route of the service)
