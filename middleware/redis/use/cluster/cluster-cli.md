## 客户端连接

```
redis-cli -a 密码 -p 端口 
```

## 集群连接

```
redis-cli -c -a 密码 -p 端口
```

## 关闭服务端

```bash
redis-cli -p 6379 -a 密码
>shutdown
# 或者直接向服务端发送一个命令
redis-cli -a 密码 -p 端口 shutdown
```

## 集群握手

- 这里是自动化握手

> **--cluster-replicas **设置副本数量
>
> 切片集群需要三主，如果设置副本为1，这里需要设置6台机器

```
redis-cli -a 密码 --cluster create ip:端口 ... ip6:端口6  --cluster-replicas 1
```

