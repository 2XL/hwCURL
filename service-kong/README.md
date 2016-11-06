### Kong [site](https://getkong.org/) && [docs](https://getkong.org/docs/) 
  OpenSource API gateway and micro-service management layer, 
  delivering high performance and reliability.
  
## Kong Endpoints
 * apis
 * consumer
## Get Started

 * setup & provision local Kong service using Docker:
```
./startKong.sh # ... check script for provision details
```

 * check Kong is running
```
http localhost:8001 # should return: 200
```
 * register api to Kong
    * name: service name
    * upstream_url = location of the service can be [DNS/LOCAL_IP/IP], direccion de redireccion
    * request_host = dns_name [CAN BE ANYTHING], tag interno de identificacion
    * request_path = uri [CAN CONTAIN WILDCARD]
```
# kong api admin is routed through port 8001
http POST localhost:8001/apis \
 name=demo \
 upstream_url=http://mockbin.org/request \
 request_host=api.demo.com
```
 * api call
```
# kong api service is delivered through proxy port 8000
http localhost:8000 Host:api.demo.com # request_host
```
 * consumer
```
# list
http localhost:8001/consumers
# register consumer
http POST localhost:8001/consumers \
    username=mo
    customer_id=whatever@identifier
```
 * setup plugin key-auth
```
## bind <PLUGIN> to api
# http POST localhost:8001/apis/<SERVICE_ID>/plugins \
#    name=<PLUGIN_NAME>
# for instance : key-authentication
http POST localhost:8001/apis/f6224089-5ff6-4652-85da-0d983309cdf8/plugins \
 name='key-auth'
# the access will be denied for unauthorized consumers
## grant consumer key-auth authorization
http POST localhost:8001/consumers/<CONSUMER_ID>/key-auth key=SECRET_KEY
# for instance : consumer_id: 6d8e7a90-cab0-45f2-8c6d-2c30c8d7820f
http POST localhost:8001/consumers/6d8e7a90-cab0-45f2-8c6d-2c30c8d7820f/key-auth \
 key=mo
## access with key
http localhost:8000<URI> Host:<UPSTREAM_URL> X-AUTH:mo
# return a list of consumer keys 
http GET localhost:8001/consumers/<CONSUMER_ID>/key-auth
# generate random key for consumer
http POST localhost:8001/consumers/<CONSUMER_ID>/key-auth
```

* setup plugin rate-limiting
```
http POST localhost:8001/plugins \
    api_id=<API_ID> \
    name=rate-limiting \
    config.minute=5          
# api request rate limted to 5 minutes. : return 429 if exceeds
http POST localhost:8001/plugins \
    api_id=<API_ID> \
    name=rate-limiting \
    config.minute=5 \
    consumer_id=<CONSUMER_ID> \
# same as previous but also with consumer access rate limit
   
```

* monitoring Kong requests with Galileo
```
curl -X POST http://{kong}:8001/apis/{api}/plugins/ \
    --data "name=galileo" \
    --data "config.service_token={service_token}" \
    --data "config.environment=default-environment"
    
    curl -X POST http://localhost:8001/apis/f6224089-5ff6-4652-85da-0d983309cdf8/plugins/ \
        --data "name=galileo" \
        --data "config.service_token=53b853b0a44011e68f7785eaa86feb79" \
        --data "config.environment=default-environment"
```



## Kong Code Snippets

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



* Request Sample
 
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

## Acronyms

* URI: Uniform Resource Identifier (route of the service)


## Concept

* Mocking: is primarily used in unit testing. An Object under test may have
dependencies on other objects. To isolate the behaviour of the object you want to test,
you replace the other objects by mocks that simulate the behaviour of the real objects.