[TOC]

## 简介

- 文档地址 [provision](https://docs.mainflux.io/provision/)

- 相关名词

  - entities 实体

  - users 用户

  - channels 通道

  - things 事物


## 平台管理

### 用户管理

#### 创建用户

```bash
# cd
cd go/src/mainflux/mainflux
# 创建
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" https://localhost/users -d '{"email":"82418@163.com", "password":"12345678"}'
```

#### 登录获取秘钥

```bash
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" https://localhost/tokens -d '{"email":"82418@163.com", "password":"12345678"}'
```

```json
{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw"}
```

#### 获取所有用户

- 这里的文档在[api](https://docs.mainflux.io/api/)

```
curl -s -S -i -X GET -H "Authorization: <user_token>" http://localhost/users
```

```json
curl -s -S -i -X GET -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" http://localhost/users
```

```json
{"total":3,"offset":0,"limit":10,"users":[{"id":"edcb870a-756a-4295-b833-24589b5192f2","email":"82418@163.com"},{"id":"63f96f83-6f04-48a4-99ec-acf6c136d869","email":"admin@example.com"},{"id":"e5d953e4-613e-4245-b55b-5defc87d6f0c","email":"nervous_sammet@email.com"}]}
```

### 系统配置 配置things

- 相关接口可能会被bulk批量操作接口替换

- 创建语句，user_auth_token的作用是为指定的用户创建things

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/things -d '{"name":"weio"}'
```

- 替换token后的语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" https://localhost/things -d '{"name":"weio"}'
```

- 执行结果

```yaml
HTTP/2 201
server: nginx/1.20.0
date: Tue, 09 Nov 2021 07:34:50 GMT
content-type: application/json
content-length: 0
# 注意下面这一行location的值
location: /things/b01ad0ca-9a65-4c25-96ae-723246753e4e
warning-deprecated: This endpoint will be depreciated in v1.0.0. It will be replaced with the bulk endpoint currently found at /things/bulk.
access-control-expose-headers: Location
```

#### 批量配置things

- bulk 批量
- 事务性，要么都创建，要么都不创建
- 创建语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/things/bulk -d '[{"name":"weio"},{"name":"bob"}]'
```

- 替换token后的语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" https://localhost/things/bulk -d '[{"name":"weio"},{"name":"bob"}]'
```

- 执行结果

```yaml
HTTP/2 201
server: nginx/1.20.0
date: Tue, 09 Nov 2021 09:10:59 GMT
content-type: application/json
content-length: 222
access-control-expose-headers: Location

# 得到的结果 这里的id和上面的location是一样的
{"things":[{"id":"92b1368a-5696-441f-bc67-425c9c3ab60b","name":"weio","key":"97488860-af8e-4e0e-a1ec-c9e5c34c45fe"},{"id":"70417ca1-3a3f-40a0-8fcf-ae057d532302","name":"bob","key":"3df2ad6b-c2ab-4508-a500-042f945af0df"}]}
```

#### 检索(查询)things

- Retrieving 检索

- 查询语句

```json
# 查询
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things

# 请求参数 便宜量和查询量 默认0,10上限为100
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things?offset=0&limit=5
# 请求参数 元数据
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things?offset=0&limit=5&metadata="\{\"serial\":\"123456\"\}"
```

- 替换token后的查询语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" https://localhost/things

curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" https://localhost/things?offset=0&limit=5

curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" https://localhost/things?offset=0&limit=5&metadata="\{\"serial\":\"123456\"\}"
```

- 查询结果

```yaml
HTTP/2 200
server: nginx/1.20.0
date: Tue, 09 Nov 2021 09:14:46 GMT
content-type: application/json
content-length: 385
access-control-expose-headers: Location

# 格式化之后可能更好看
{"total":5,"offset":0,"limit":10,"order":"","direction":"","things":[{"id":"b01ad0ca-9a65-4c25-96ae-723246753e4e","name":"weio","key":"06881899-98d1-4ec6-a9b1-bd698ad38ea9"},{"id":"92b1368a-5696-441f-bc67-425c9c3ab60b","name":"weio","key":"97488860-af8e-4e0e-a1ec-c9e5c34c45fe"},{"id":"70417ca1-3a3f-40a0-8fcf-ae057d532302","name":"bob","key":"3df2ad6b-c2ab-4508-a500-042f945af0df"}]}
```

#### 搜索things

- 语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/things/search -d '{"metadata":{"foo":"bar"}, "name":"bob", "limit": 10, "offset":0, "order":"name", "dir":"desc"}'
```

- 替换token后的语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" https://localhost/things/search -d '{"metadata":{"foo":"bar"}, "name":"bob", "limit": 10, "offset":0, "order":"name", "dir":"desc"}'
```

#### 移除things

- 查询语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X DELETE -H "Authorization: <user_auth_token>" https://localhost/things/<thing_id>
```

- 替换token后的语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X DELETE -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw" https://localhost/things/92b1368a-5696-441f-bc67-425c9c3ab60b
```

### 系统配置 配置channel

- 相关接口可能会被bulk批量操作接口替换

#### 增

#### 删

#### 改

#### 查

### 访问控制

- 更多接口见接口文档

- things连接到channel才能发消息

- 相关接口可能会被bulk批量操作接口替换

#### 连接things到channel

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X PUT -H "Authorization: <user_auth_token>" https://localhost/channels/<channel_id>/things/<thing_id>
```

#### 连接多个things到channel

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/connect -d '{"channel_ids":["<channel_id>", "<channel_id>"],"thing_ids":["<thing_id>", "<thing_id>"]}'
```

#### 查看channel和things的连接关系

- 指定channels

```yaml
# 和channel连接的things
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/channels/<channel_id>/things

# 和channel非连接的things
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/channels/<channel_id>/things?connected=false
```

- 指定things

```yaml
# 连接
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things/<thing_id>/channels

# 非连接
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things/<thing_id>/channels?connected=false
```

#### 断开连接

```yaml
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X DELETE -H "Authorization: <user_auth_token>" https://localhost/channels/<channel_id>/things/<thing_id>
```

### 配置服务

### 证书服务

