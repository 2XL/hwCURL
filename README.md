[basic](http://www.yilmazhuseyin.com/blog/dev/curl-tutorial-examples-usage/)
[intermediate](http://www.slashroot.in/curl-command-tutorial-linux-example-usage)
[advanced](https://curl.haxx.se/docs/httpscripting.html)


#### cURL features

* URI Protocol support (protocol://previx): DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS,  IMAP, IMAPS,  LDAP,  LDAPS,  POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMTP, SMTPS, TELNET and TFTP
* Pause and resume downloads
* Supports <COOKIES>, <FORMS> and <SSL>
* Its open source
* Multiple uploads with a single command
* Progress bar, rate limiting and download time details
* IPV6 support

#### cURL Basic Query examples

* Make a <REQUEST> without any data:
```
#  the default protocol is GET
curl http://<domain>/<extension>


```

* Make a <REQUEST> with different <PROTOCOL> 
```
# --request | -X [GET|POST|DELETE|PUT] 
curl -x <PROTOCOL> <URL>
```

* Make a <REQUEST> with <DATA> from <QUERY> | <FILE>
```
# --data "<key=value[&key=value]>"
curl -X <PROTOCOL> <URL> --data 'key=value&key2=value2'

# --data @<filename>
curl -X PUT <URL> --data @<FILENAME>

```

* Make a <REQUEST> with <HEADERS>
```
# --header
curl -x GET <URL> --header '<TAG_KEY>:<TAG_VALUE>'
```

* Get <RESPONSE> with HTTP <HEADERS>
```
# --include
curl --request <PROTOCOL> <URL> --include
```


#### cURL examples

* Store <RESPONSE> to file
```
# -o <FILENAME> | > <FILENAME> # redirection method on linux

```

* Download M files in 1 command
```
# same HTTP connection to download multiple files <speedup less overhead>
curl    -O <LOCAL_NAME> <URL> \
        -O <URL>\
        -O <URL>

```

* Automatic Redirect to new URL from (3xx)
```
# -L
curl -L <sitename>
```

* Resume/Pause download
```
# -O 
curl -O <URL/FILE>
# cancel it with: CTRL + C
# -C 
curl -C - -O <URL/FILE>
```

* <REQUEST> through <PROXY_SERVER>
```
# --proxy-user <USER>:<PASS> # proxy credentials
curl -x <PROXY_PROTO>://<PROXY_HOST>:<PROXY_PORT> \
        -proxy-user <USER>:<PASS>
        -L <URL>
```

* Ignore SSL Certificate with cURL
```
# -k
curl -k https://<URL>
```

* Download Rate Limit with cURL
```
# Limit the download speed to desired value
# --limit-rate <#UNIT>
# -O <URL>
curl --limit-rate 100k -O <URL>
# <UNIT>: [B|k|m|G] > byte, kilobytes, megabytes, gigabytes
```

* Download File depending upon file modification time
```
curl -z "<DAY_##>-<MONTH_XXX>-<YEAR_##>" <URL/FILE>

```

##### FTP

* Download File from FTP server using cURL
```
# --user <USERNAME>:<PASS>
# -o <DOWNLOADED_FILE_NAME>
curl ftp://<URL/FILE> --user x:x -o <FANCY_NAME_HERE>
```

* List File from FTP server directory
```
# --user <USERNAME>:<PASS> 
curl ftp://<URL/FILE> --user x:x  
```

* Upload File to FTP server
```
# -T <FILE_TO_UPLOAD>
curl -T <FILE_TO_UPLOAD> ftp://<URL_FTP_SERVER> --user x:x
```

* Delete File from FTP server
```
# -X 'DELE <FILE_NAME>'
curl ftp://<URL/DIR> -X 'DELE <FILE_NAME>' --user x:X
```

##### SMTP

* Sending an Email
```
# --upload-file <MAILCONTENT>
# --insecure | -k # ignore SSL certificates
curl    --url "smtps://smtp.example.com:465" \
        --ssl-reqd \
        --mail-from "user@example.com" \
        --mail-rcpt "friend@example.com" \
        --upload-file mailcontent.txt \
        --user "user@example.com:password" \
        --insecure
```

##### REST API

* Update request
```
# -X <REQUEST_METHOD>
# -u <USER>:<PASS> <API_URL>
# -H <HEADER_KEY:VALUE>
# -d @<FILEPATH> # contain the configuration options with correct syntax 
curl    -X POST \
        -u admin:admin http://example.com/myconfigs/status \
        -H content-type:application/xml \
        -d @/home/user/file.xml
```

##### Session COOKIE

* Load / Store
```
# -b (<FILE_NAME> | <KEY=VALUE>) # if there is no "=" it will seek a file
# load from file
curl -b <COOKIE_FILE> <URL>
# load from string
curl -b "cookie_key=cookie_value" <URL>

```


##### HTTP Headers

* Track progress and see <REQUEST> <HEADERS>
```
# -v # verbose (request & response) headers
curl -v <URL>
# * 
# > request header field
# < response header field
# html
# -I # only (response) headers (<) are displayed
curl -I <URL>
```

* Modify User Agent In HTTP request
```
# Servers might respond with different layouts according UserAgent 
# -A "<USER AGENT STRING>" # NAME/VERSION (OS;)
curl -A "Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.3)" <URL>
```

* Modify Headers
```
# Accept & Content-type
curl    -H "Accept: application/xml" \
        -H "Content-Type: application/xml" 
        http://example.com
```

* Verify SSL
```
# --cacert <CERT_FILE.crt>
curl    --cacert my-ca.crt \
        https://example.com
```

#### HTTP status CODE

1.	1xx Informational
2.	2xx Success
3.	3xx Redirection:
    1. permanent
    2. temporal
4.	4xx Client Error
    4. don't exists
    5. not accepted methods
    15. unsupported media type
5.	5xx Server Error


#### Concepts

* HTTP Headers: contains details so that the server and the client can understand each other in a much better way. 
* CA: Certificate Authority Certificate
