[TOC]

# 初体验
## 运行服务端

```bash
make run  # 本质是docker-compose
```

## 下载命令行工具

- 这里就不提供下载链接了，我们使用构建的客户端，放到go的bin中
- cli工具为mainflux-cli，为了简化，后面我们使用mcli

## 测试

- 运行

```bash
mcli provision test
```

- 运行结果

```json
# 创建了测试用户
{
  "email": "nervous_sammet@email.com",
  "password": "12345678"
}

# 登录获取token
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzY0NzgyNzEsImlhdCI6MTYzNjQ0MjI3MSwiaXNzIjoibWFpbmZsdXguYXV0aCIsInN1YiI6Im5lcnZvdXNfc2FtbWV0QGVtYWlsLmNvbSIsImlzc3Vlcl9pZCI6ImU1ZDk1M2U0LTYxM2UtNDI0NS1iNTViLTVkZWZjODdkNmYwYyIsInR5cGUiOjB9.w5cGCIpyeJBIyqqRz4jKGV6OcYVZh61FXA9dyvdi4NQ"

# 创建资源、两个things和两个通道
[
  {
    "id": "52835a0d-2d48-42bd-9c16-670d977da1aa",
    "key": "9528b74a-aebb-44bf-889e-cde9fe6619f2",
    "name": "d0"
  },
  {
    "id": "29421b87-c71d-4364-8b6f-6013ff20de88",
    "key": "be2cd37b-805e-493c-b01e-ba3ab5f402a7",
    "name": "d1"
  }
]

[
  {
    "id": "c00bdcce-6898-4d1c-9959-534ef77120c6",
    "name": "c0"
  },
  {
    "id": "21686bba-8b3a-4514-80bf-f5d67c63e6b8",
    "name": "c1"
  }
]
```

## 测试发消息

```bash
mainflux-cli messages send c00bdcce-6898-4d1c-9959-534ef77120c6 '[{"bn":"some-base-name:","bt":1.276020076001e+09, "bu":"A","bver":5, "n":"voltage","u":"V","v":120.1}, {"n":"current","t":-5,"v":1.2}, {"n":"current","t":-4,"v":1.3}]' 9528b74a-aebb-44bf-889e-cde9fe6619f2

# ok
```

## 补充说明

- 根据后面的操作，我们大概得到一些信息
- 创建的things和channel要连接才能发消息，上面的测试命令推测已经连接
- 发消息时，数据结构主要分
  - channel_id，消息通道
  - things_id 发送者，物(品)
  - 消息
