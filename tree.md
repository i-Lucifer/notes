## 书单

- 编程珠玑

<!-- ## 计算机基础学科

### 计算机操作系统

### 计算机组成原理

### 计算机组成设计

### 计算机网络 -->

### 数据结构与算法

本节内容主要参考《数据结构导论》《漫画算法》《算法导论》《编程珠玑》

<!-- - [算法概述](./science/data-structure/algorithm-overview.md)  -->

- [数据结构基础](./science/data-structure/data-structure.md)

<!--  - [树](./science/data-structure/tree.md)

- [排序算法](./science/data-structure/sort-algo.md)

- [面试常见算法](./science/data-structure/aigo-interview.md)

- [算法的实际应用](./science/data-structure/aigo-apply.md)  -->

- 排序算法
    - [链表反转](./science/algorithm/list-reverse.md)



## 物联网 loT(Internet of Things)
- [mainflux框架](./lot/mainflux/00-tree.md)



## 关系型数据库

### Mysql
- 数据库范式
- 存储引擎
- 事务与锁
- 索引
- 查询缓存
- 数据库备份
### postgres

## 缓存
- [数据一致性问题](./middleware/redis/qa/data-consistency.md)

## 内存数据库

- redis

《Redis设计与实现》本系列均为阅读同名书籍，加上自己的理解，撰写的文档，如果有不正之处，敬请指出。
- [c语言字符串与redis字符串](./middleware/redis/design/data_type/sds.md)
- [链表](./middleware/redis/design/data_type/sds.md)
- [链表](./middleware/redis/design/data_type/list_node.md)
- [字典](./middleware/redis/design/data_type/dict.md)


[Redis面试相关](./middleware/redis/interview.md)
<<<<<<< HEAD


[Redis数据持久化]
=======
[Redis线程阻塞]
[Redis内存淘汰]

>>>>>>> 26db209 (tree)

## 消息队列

- kafka



## 分布式

- 分布式原理
- 公示算法



## 云原生解决方案

- 日志 ELK
- 链路追踪 skywalking
- 监控 Prometheus



## 微服务

- 服务注册与发现



## CICD

- gogs
- docker
- jenkins
- k8s


## golang
数据类型
- iota iota的本质是常量表遍历的索引
- [管道](./go/data_type/channel.md)
- [渐进式rehash](./go/data_type/map.md)
- [字符串](./go/data_type/string.md)
- [数组和切片](./go/data_type/slice.md)
- [结构体](./go/data_type/struct.md)

(这一条不太清楚是否应该归为数据类型)
- [接口](./go/data_type/interface.md)
控制结构
- select
- for-range
协程
- [协程、调度模型、调度策略](./go/routine/routine.md)
内存管理
- [内存分配]
- [垃圾回收]
- [逃逸分析]
并发控制
- channel
- WaitGroup
- context
- mutex
- RWMutex
反射
- 接口与反射定律
测试相关
- 单元测试
- 基准测试
异常处理
- [defer](./go/exception_handle/defer.md)
- [panic](./go/exception_handle/panic.md)
- [recover](./go/exception_handle/recover.md)
定时器
- 一次性定时器Timer
- 周期性定时器Ticker

版本管理
依赖管理

语言特性
- 语法糖
- 语言陷阱
