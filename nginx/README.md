# was서버에 sourceIP가 web서버IP로만 찍힐 때 아래 설정을 해주면 실제 발신지의 sourceIP가 찍힌다.
/etc/nginx/conf.d/common/proxy_header.conf  
```
proxy_pass_header Server;
proxy_set_header Host $http_host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Scheme $scheme;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header Client-IP  $remote_addr;
