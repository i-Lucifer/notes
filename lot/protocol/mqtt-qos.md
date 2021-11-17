[TOC]

### QoS 服务质量

#### 发送者与接收者

QoS是Sender和Receiver之间的协议，而不是Publisher和Subscriber之间的协议。

QoS1中Pubisher发送一条数据，只能保证Broker至少收到一次，对应的Sub是否能收到消息，取决于Sub的QoS协商。

- 发送方(Sender)
- 接收方(Receiver) 

#### 质量等级

| 等级 | 说明                           | 最少通讯次数 |
| ---- | ------------------------------ | ------------ |
| 0    | At most once 最多一次          | 1            |
| 1    | At least once 最少一次         | 2            |
| 2    | Exactly once 只有一次 恰好一次 | 4            |

##### 最多一次

| 发送者             | 接收者 |
| ------------------ | ------ |
| 发送数据，丢弃数据 |        |

##### 最少一次

这里的ACK包标识（Package Identifier），后面我们简称Id

| 发送者                                | 接收者               |
| ------------------------------------- | -------------------- |
| 发送数据，保留数据，等待ACK，超时重试 |                      |
|                                       | 接收数据 返回一次ACK |
| 接收到ACK，丢弃数据                   |                      |

##### 恰好一次

| 发送者                            | 接收者               |
| --------------------------------- | -------------------- |
| 发送数据，保留，等待ACK，超时重试 |                      |
|                                   | 接收数据 返回一次ACK |
| 接收到ACK，丢弃数据               |                      |
