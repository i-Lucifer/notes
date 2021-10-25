# Redis 命令手册
redis 其他文档见飞书文档

- 五种基本数据类型
  - [字符串](./string.md)
  - [哈希](./hash.md)
  - [列表](./list.md)
  - [集合](./set.md)
  - [有序集合](./sortset.md)
- 三种扩展类型
  - [bitmap 位图](./bitmap.md)
  	- BloomFilter 布隆过滤器
  - [Geo地理位置类型](./geo.md)
  - [HyperLogLog](./hyperlog.md)
- 一种高级类型
  - [数据流](./stream.md)

- [数据库操作命令](./database.md)
- [自动过期命令](./expire.md)
- [事务命令](./transaction.md)
- [Lua脚本命令](./lua.md)
- [持久化命令](./persistence.md)
- [发布与订阅命令](./pub-sub.md)
- [复制命令](./replication.md)
- [客户端与服务端命令](./sys.md)
- [配置选项命令](./config.md)
- [调试命令](./debug.md)
- [内部命令](./internal.md)
- [危险命令](./danger.md)


## 应用

- 分布式锁
- 漏斗限流

## 集群操作

- 集群模式
  - 主从
  - 哨兵
  - [cluster 集群命令](./cluster/cli.md)
