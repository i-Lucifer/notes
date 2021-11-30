## 跨域

### 产生原因

- 浏览器的同源策略

### 三种分类

- 域名跨域
  - [www.baidu.com](http://www.baidu.com/)

- api.baidu.com

- 端口跨域(80 8080)
  - api.baidu.com:80

- api.baidu.com:8080

- 协议跨域(http https)
  - http://[www.baidu.com](http://www.baidu.com/)

- https://[www.baidu.com](http://www.baidu.com/)

### 解决方案

- jsonp

- 后端CORS放行

### 原理

option请求