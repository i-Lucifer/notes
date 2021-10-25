## 正常的七层转发

```nginx
server {
    listen       80;
    server_name  www.gin-vue.com;

    location ~ / {
        client_max_body_size    200m;
        proxy_pass http://127.0.0.1:8080;
    }
}
```

## nginx支持的四层转发

- 四层转发需要[官方文档](https://nginx.org/en/docs/stream/ngx_stream_core_module.html)提到的ngx_stream_module.so模块支持
- 示例一

```nginx
stream {
    upstream rabbitserver {
    		server 127.0.0.1:5672;
        server 11.0.0.1:5672;
    }
}
```

- 官网示例二

```nginx
worker_processes auto;

error_log /var/log/nginx/error.log info;

events {
    worker_connections  1024;
}

stream {
    upstream backend {
        hash $remote_addr consistent;

        server backend1.example.com:12345 weight=5;
        server 127.0.0.1:12345            max_fails=3 fail_timeout=30s;
        server unix:/tmp/backend3;
    }

    upstream dns {
       server 192.168.0.1:53535;
       server dns.example.com:53;
    }

    server {
        listen 12345;
        proxy_connect_timeout 1s;
        proxy_timeout 3s;
        proxy_pass backend;
    }

    server {
        listen 127.0.0.1:53 udp reuseport;
        proxy_timeout 20s;
        proxy_pass dns;
    }

    server {
        listen [::1]:12345;
        proxy_pass unix:/tmp/stream.socket;
    }
}
```

