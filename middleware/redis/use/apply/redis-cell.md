## 限流简介

- 为什么要使用限流？

  - 用户增长过快
  - 某个热点事件
  - 竞争对象爬虫
  - 恶意的刷单

  以上的这些情况都是无法预知的，不知道什么时候会有10倍甚至20倍的请求进来，如果真的碰到这种情况，临时扩容是来不及的，所以需要对请求进行一些限制。

- 通常的策略就是拒绝多余的访问，或者让多余的访问排队等待服务，或者引流。

-  接口限流通常和接口监控一起使用，常用的接口监控和工具如普罗米修斯。

### 限流方式
- nginx限流
- 应用限流

### 计数器限流
- 计数器限流也叫时间窗口滑动限流
- 缺点 不适合大量访问 这里不做过多介绍

### 漏斗限流

- 漏斗限流说明
  - 漏斗限流与令牌桶限流方式类似
- 原理
  - 初始化一个有一定容量的漏斗
  - 漏斗可以按照一定的速率漏水
  - 对服务端发起请求时，向漏斗中注水
  - 水满时，请求被拒绝，并告诉客户端多久后可以重试

- 实现方式
  - 方式一 代码漏斗限流 缺点 分布式系统中 不能做统一的限流

  - 方式二 使用redis做漏斗限流



###  基于redis-cell的漏斗限流

- redis-cell是什么？

  - redis-cell是一个用rust语言编写的基于令牌桶算法的的限流模块。
  - redis虽然是C语言写的程序，但是支持通过各种语言写的模块进行拓展。

- 如何安装？

  - 一、[点击此处下载redis-cell扩展包](https://github.com/brandur/redis-cell/releases)并解压缩

  - 二、将libredis-cell移动到可访问的目录，如**/usr/local/Cellar/redis/**

    - mac后缀是.dylib
    - linux后缀是.so

  - 三、打开redis.conf配置文件，加载redis-cell模块

    ```php
    loadmodule /usr/local/Cellar/redis/libredis-cell.dylib
    ```
    
  - 四、重启redis服务
  
- 如何使用？

  - redis-cell仅一个命令

  ```redis
  CL.THROTTLE <key> <max_burst> <count per period> <period> [<quantity>]
  ```

  - 使用示例
    - 对帖子1进行回复
    - 初始情况下允许回复15次
    - 60秒内允许回复30次，即漏水速率是0.5
    - 每次回复占用1次回复机会

  ```
  cl.throttle reply:1 15 30 60 1
  ```

  - 返回值示例

  >1) (integer) 0      # 0 允许 1拒绝
  >
  >2) (integer) 16    # 初始容量
  >
  >3) (integer) 1      # 漏斗剩余空间
  >
  >4) (integer) -1     # 如果被拒绝 请在多少秒后重试
  >
  >5) (integer) 28    # 漏斗漏空需要时间

- PHP使用Redis-cell
  - 下载composer包，包内提供更加详细的文档

  ```bash
  composer require easyunit/moka-sdk=v0.0.2
  ```
  - 使用
  
  ```php
   /**
  * 限流
  * @param String $action    要进行的操作
  * @param Int    $max_burst 漏斗容量||初始令牌数
  * @param Int    $max_count 消化速率||时间内产生令牌的数量
  * @param Int    $period    时间限制
  * @param Int    $apply     默认申请令牌数量
  * @return 范围值是一个数组，如果返回的不是数组，则redis-cell未安装成功，可通过redis-cli尝试
  */
  LeakyBucket::IsPass($action, $max_burst = 15, $max_count = 30, $period = 60, $apply = 1)
  ```
  
  - 示例
    - 允许用户1，每秒进行60次reply操作
  
  ```php
  LeakyBucket::IsPass('reply:1', 60, 60,1,$apply = 1)
  ```
