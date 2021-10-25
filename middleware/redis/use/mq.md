## 队列相关
### 普通list
- [见五种常见类型](./data-type.md)


### 延时队列
- [知乎文档](https://zhuanlan.zhihu.com/p/87113913)
#### RabbitMQ 延时队列
- 优点:消息持久化，分布式
- 缺点:延时相同的消息必须扔在同一个队列，每一种延时就需要建立一个队列。因为当后面的消息比前面的消息先过期，还是只能等待前面的消息过期，这里的过期检测是惰性的。
#### DelayQueue 延时队列(没了解过)
- 优点:无界、延迟、阻塞队列
- 缺点:非持久化

#### Redis 延迟队列
- 消息持久化，消息至少被消费一次
- 实时性：存在一定的时间误差（定时任务间隔）
- 支持指定消息 remove
- 高可用性
- Redis 的特殊数据结构 ZSet 满足延迟的特性
- 实现方式
    - 有序集合 分数作为时间戳

### Redis Stream

- list的加强版
- RabbitMQ和kafk的Redis版

- 增删查
  - ```*```代表自动生成id 格式为millisecond_int-index_int 最小为0-0
  - ```-```代表最小id
  - ```+```代表最大id

| 命令                                             | 说明             |
| ------------------------------------------------ | ---------------- |
| xadd key * field1 val1 field2 val2 [fieldn valn] | 追加消息         |
| xdel key id                                      | 删除消息         |
| del key                                          | 删除整个队列     |
| xrange key - +                                   | 获取区间消息列表 |
| xlen key                                         | 获取消息长度     |
| xinfo stream key                                 | 获取长度起止信息 |
| xinfo groups key                                 | 观察消费组信息   |
| xinfo consumers key cg1                          | 查看消费者信息   |

- 普通消费(0-0代表头部)

  - 队首 xread count 数量 streams key 0-0
  - 队尾 xread count 数量 streams key $    默认结果是nil 也就是空
  - 队尾阻塞 xread block 阻塞时间 count 1 streams key $   直到有新field加入
    - 0代表永远阻塞
    - 1000代表阻塞1s

- 消费组消费

  - 从头部开始消费

    - xgroup create key cg1 0-0

  - 从尾部开始消费，只接受新消息，忽略现有消息

    - xgroup create key cg2 $

  - xinfo stream key 设置过消费组后 查看消费组信息

    ```bash
     9) "groups"
    10) (integer) 0
    ```

  - 消费
    - xreadgroup 读取待消费信息
    - xack 通知消费完毕
    - 从最后一条消息开始读 >
    - xreadgroup group cg1 c1 count 1 streams key >
    - 阻塞 xreadgroup group cg1 c1 block 0 count 1 streams key >

```bash
127.0.0.1:6379> xinfo groups userqueue
1) 1) "name"
   2) "cg1"   
   3) "consumers"
   4) (integer) 1    ## 一个消费者
   5) "pending"
   6) (integer) 12   ## 12条消息待xack通知消费完毕
   7) "last-delivered-id"
   8) "1595693189108-0"
2) 1) "name"
   2) "cg2"
   3) "consumers"
   4) (integer) 0
   5) "pending"
   6) (integer) 0
   7) "last-delivered-id"
   8) "1595692427692-0"
```

- ack通知消费成功 (一定要记住id呀)
  - xack key cg1 id



### ack问题
- 队列最重要的就是保证消息被成功消费
- Redis作为消息队列的局限性很大，实现 ack 机制的成本相对较高(不考虑Stream时)