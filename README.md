---
# 是否首页显示
home: true

# 图片
# heroImage: /avatar.png
# heroImage: /logo.png

# 居中标题 会覆盖config中的标题
# heroText: k8s篇
# tagline: By Lucifer

# 点击框 标题与跳转地址
# actionText: 开始阅读 →
# actionLink: ./home.md

# 三个卡片
# features:
# - title: 基础
#  details: k8s安装
# - title: 使用
#  details: 使用k8s部署应用
# - title: 周边
#  details: k8s管理工具

# 页脚设置
footer: 
    Copyright © 2021 Lucifer By VuePress  豫ICP备2021024610号


# ↓↓↓↓↓ 下面的是正文
---

## 书单
易懂书籍
- 《编码：隐匿在计算机软硬件背后的语言》 计算机神作、以及B站对它的速读[读懂这本书，你就能手工自制CPU](https://www.bilibili.com/video/BV1NR4y1n7yj?spm_id_from=333.999.0.0)、
- 《码农翻身》《半小时漫画计算机》
- 《Redis资深历险》

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


## 缓存

## Redis

《Redis设计与实现》本系列均为阅读同名书籍，加上自己的理解，撰写的文档，如果有不正之处，敬请指出。
- [c语言字符串与redis字符串](./middleware/redis/design/data_type/sds.md)
- 渐进式rehash 待更新


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

## 容器与容器编排
### [docker](./ops/docker/docker.md)
### [k8s](./ops/k8s/k8s.md)


## 物联网 loT(Internet of Things)
- [MQTT协议](./lot/protocol/tree.md)


## 版本控制
- [git](./dev/git/README.md)