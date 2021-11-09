[TOC]

## 简介

- 文档地址 [provision](https://docs.mainflux.io/provision/)

- 相关名词

  - entities 实体

  - users 用户，普通用户，管理员，运营人员等

  - channels 通道，这里理解是消息通道

  - things 事物，这里应该是指物联网里的物


## 平台管理

### 用户管理

#### 增 创建用户

- 访问接口需要证书，所以我们默认在项目跟目录执行shell

```bash
# cd
cd go/src/mainflux/mainflux
```

- 创建用户

```bash
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" https://localhost/users -d '{"email":"82418@163.com", "password":"12345678"}'
```

#### 增 登录获取秘钥

- 登录
  - -i 参数会输出相应的状态码等信息，我们默认隐藏掉

```bash
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" https://localhost/tokens -d '{"email":"82418@163.com", "password":"12345678"}'
```

- 结果 状态码 201 请求结果后面美化后贴入文档

```json
{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0Nzg5MjQsImlhdCI6MTYzNjQ0MjkyNCwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6IjgyNDE4QDE2My5jb20iLCJpc3N1ZXJfaWQiOiJlZGNiODcwYS03NTZhLTQyOTUtYjgzMy0yNDU4OWI1MTkyZjIiLCJ0eXBlIjowfQ.ddhDFW561GcYh3NO0SDrylWIP6Um0WQHIlbL7yMjJGw"}
```

#### 查 查询所有用户

- 这个接口在[api](https://docs.mainflux.io/api/)篇，不在配置篇，这里属于扩展
- 这里是第一次用到token，为了方便，我们后续将读取文件中的token

```bash
curl -s -S -i -X GET -H "Authorization: <user_token>" http://localhost/users
```

- shell读取token，然后发送请求，也可以用curl直接读文件，这里已经实现shell，不再尝试

```bash
for token in `cat token.txt` # 读文件
do
# echo ${token:10:267} # 字符串截取
curl -s -S -X GET -H "Authorization: ${token:10:267}" http://localhost/users
done
```

- 请求结果
  - 看结果，我们是可以传递偏移量，还有查询数量的，由于这个接口是从后面找的，这里先不做介绍

```json
{
    "total": 3,
    "offset": 0,
    "limit": 10,
    "users": [
        {
            "id": "edcb870a-756a-4295-b833-24589b5192f2",
            "email": "82418@163.com"
        },
        {
            "id": "63f96f83-6f04-48a4-99ec-acf6c136d869",
            "email": "admin@example.com"
        },
        {
            "id": "e5d953e4-613e-4245-b55b-5defc87d6f0c",
            "email": "nervous_sammet@email.com"
        }
    ]
}
```

### 系统配置 配置things(物)

#### 增 增加一条things

- 相关接口可能会被bulk批量操作接口替换

- user_auth_token的作用是为指定的用户创建things

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/things -d '{"name":"weio"}'
```

- 执行结果
  - 增加一条信息时，返回的不是json信息，所以我们在这里放入201状态码等信息


```yaml
HTTP/2 201
server: nginx/1.20.0
date: Tue, 09 Nov 2021 07:34:50 GMT
content-type: application/json
content-length: 0
# 注意下面这一行location的值，是things的id
location: /things/b01ad0ca-9a65-4c25-96ae-723246753e4e
warning-deprecated: This endpoint will be depreciated in v1.0.0. It will be replaced with the bulk endpoint currently found at /things/bulk.
access-control-expose-headers: Location
```

#### 增 批量增加things

- bulk 批量
- 事务性，要么都创建，要么都不创建

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/things/bulk -d '[{"name":"weio"},{"name":"bob"}]'
```

- 执行结果

```yaml
# 得到的结果 这里的id和上面的location是一样的
{
    "things": [
        {
            "id": "92b1368a-5696-441f-bc67-425c9c3ab60b",
            "name": "weio",
            "key": "97488860-af8e-4e0e-a1ec-c9e5c34c45fe"
        },
        {
            "id": "70417ca1-3a3f-40a0-8fcf-ae057d532302",
            "name": "bob",
            "key": "3df2ad6b-c2ab-4508-a500-042f945af0df"
        }
    ]
}
```

#### 查 检索(查询)things

- Retrieving 检索
- 查询可以加参数
  - 偏移量
  - 查询限制 默认为10，上限100
  - 元数据参数


```yaml
# 查询
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things

# 请求参数 实际测试只有offset生效了，如果把limit放在offset前，则只有limit生效
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things?offset=0&limit=5

# 请求参数 元数据
curl -s -S -i --cacert docker/ssl/certs/ca.crt -H "Authorization: <user_auth_token>" https://localhost/things?offset=0&limit=5&metadata="\{\"serial\":\"123456\"\}"
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
{
    "total": 5,
    "offset": 0,
    "limit": 10,
    "order": "",
    "direction": "",
    "things": [
        {
            "id": "b01ad0ca-9a65-4c25-96ae-723246753e4e",
            "name": "weio",
            "key": "06881899-98d1-4ec6-a9b1-bd698ad38ea9"
        },
        {
            "id": "92b1368a-5696-441f-bc67-425c9c3ab60b",
            "name": "weio",
            "key": "97488860-af8e-4e0e-a1ec-c9e5c34c45fe"
        },
        {
            "id": "70417ca1-3a3f-40a0-8fcf-ae057d532302",
            "name": "bob",
            "key": "3df2ad6b-c2ab-4508-a500-042f945af0df"
        }
    ]
}
```

#### 查 搜索things

- 这里的也是查，与上面的查询相比，不走GET请求，走POST请求，携带了更多的参数

```yaml
# 官网示例的参数
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/things/search \
-d '{"metadata":{"foo":"bar"}, "name":"bob", "limit": 10, "offset":0, "order":"name", "dir":"desc"}'

# 去掉元数据的查询参数
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X POST -H "Content-Type: application/json" -H "Authorization: <user_auth_token>" https://localhost/things/search \
-d '{"name":"bob", "limit": 7, "offset":3, "order":"name", "dir":"desc"}'
```

- 查询的结果

```json
{
    "total": 6,
    "offset": 3,
    "limit": 2,
    "order": "name",
    "direction": "desc",
    "things": [
        {
            "id": "9965ec3c-2111-4c38-a52e-5dd6eea45029",
            "name": "bob",
            "key": "34fdfded-c1df-421d-8a95-977f4944f4db"
        },
        {
            "id": "acae78fc-fc9f-44da-9640-990dc3e5e12b",
            "name": "bob",
            "key": "4d936cf9-571a-4652-9699-1dfd2442ad4d"
        }
    ]
}
```

#### 删 移除things

- 查询语句

```json
curl -s -S -i --cacert docker/ssl/certs/ca.crt -X DELETE -H "Authorization: <user_auth_token>" https://localhost/things/<thing_id>
```

- 执行结果 删除成功

```yaml
HTTP/2 200 
server: nginx/1.20.0
date: Tue, 09 Nov 2021 16:31:56 GMT
content-type: application/json
content-length: 286
access-control-expose-headers: Location
```

- 再次执行结果 无可删除

```yaml
HTTP/2 204 
server: nginx/1.20.0
date: Tue, 09 Nov 2021 16:31:18 GMT
access-control-expose-headers: Location
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

