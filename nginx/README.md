# was서버에 sourceIP가 web서버IP로만 찍힐 때 아래 설정을 해주면 실제 발신지의 sourceIP가 찍힌다.
/etc/nginx/conf.d/common/proxy_header.conf  
```
proxy_pass_header Server;
proxy_set_header Host $http_host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Scheme $scheme;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header Client-IP  $remote_addr;
```

# nginx.conf 설정 예시 (호스트 및 ContextPath 병행 셋팅)
 - /etc/nginx/conf.d/watchlog/watchlog-upstream.conf 설정파일 준비  

```
upstream watchLogApi {
    ip_hash;
    server localhost:31007;
 }

upstream watchLogApi-tobe {
    ip_hash;
    server localhost:31017;
 }
```
 - /etc/nginx/conf.d/watchlog/watchlog-server.conf 설정파일 준비

```
location /watchLogApi {
    include /etc/nginx/conf.d/common/proxy_header.conf;

    access_log  /var/log/nginx/watchlog/access.log;
    error_log   /var/log/nginx/watchlog/error.log;

    proxy_pass http://watchLogApi/watchLogApi/;
    proxy_redirect     http:// $scheme://;
    proxy_read_timeout 300;
    charset utf-8;
}

location /watchLogApi-tobe {
    include /etc/nginx/conf.d/common/proxy_header.conf;

    access_log  /var/log/nginx/watchlog/access-tobe.log;
    error_log   /var/log/nginx/watchlog/error-tobe.log;

    proxy_pass http://watchLogApi-tobe/watchLogApi/;
    proxy_redirect     http:// $scheme://;
    proxy_read_timeout 300;
    charset utf-8;
}
```

- eams.conf 전체 내용 
```
upstream eams {
    ip_hash;
    server localhost:31002;
 }

include /etc/nginx/conf.d/watchlog/watchlog-upstream.conf;

server {
    listen       80;
    server_name  devattend.ajou.ac.kr;
#    return 301   https://$host$request_uri;

     location ~* /eams/(webView|js|css)/ {
        include /etc/nginx/conf.d/common/proxy_header.conf;

        proxy_pass http://eams;
        proxy_redirect     http:// $scheme://;
        proxy_read_timeout 300;
        charset utf-8;
    }

    location / {
        return 301 https://$host$request_uri;
    }

}

server {
    listen       443 ssl;
    server_name devattend.ajou.ac.kr;

    include /etc/nginx/ssl/ssl.conf;

    location ~ ^/$ {
        return 301  https://$host/eams/index.html;
    }

    location /eams {
        include /etc/nginx/conf.d/common/proxy_header.conf;

        access_log  /var/log/nginx/eams/access.log;
        error_log   /var/log/nginx/eams/error.log;

        proxy_pass http://eams;
        proxy_redirect     http:// $scheme://;
        proxy_read_timeout 300;
        charset utf-8;
    }

    include /etc/nginx/conf.d/watchlog/watchlog-server.conf;

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```
# nginx SSL 설정
 - cat /etc/nginx/ssl/ssl.conf
```
ssl_certificate             /etc/nginx/ssl/STAR.ajou.ac.kr.crt;
ssl_certificate_key         /etc/nginx/ssl/STAR.ajou.ac.kr.key;
ssl_session_timeout         5m;
ssl_protocols               TLSv1.3 TLSv1.2 TLSv1.1 TLSv1;
ssl_ciphers                 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
ssl_prefer_server_ciphers   on;

location ~ /\.ht {
  deny  all;
}
```

# 커밋 테스트를 위한 임시 
