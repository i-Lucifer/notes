## 网络模型

- OSI七层模型与TCP/IP五层模型说明
  - 七层模型是学院派，属于理论
  - <font color="orange">五层模型</font>属于实践派，是<font color="orange">七层模型的协议实现</font>
  - 程序员一般关系4-7层，nginx可以是第4层，也可以是第7层
  - 一般人员关心2-4层
  - 1层不需要我们关心，毕竟光纤怎么制作的已经有了标准，双绞线还是要了解一下的

### 七、五、四

| 序号 | 七层英文     | 七层中文   | 五层模型   | 四层模型   | 常见协议                                           | 应用        |
| ---- | ------------ | ---------- | ---------- | ---------- | -------------------------------------------------- | ----------- |
| 7    | Application  | 应用层     |            |            | http、ftp、smtp、pop3、telent、NNTP、IMAP4、Finger | nginx       |
| 6    | Presentation | 表示层     |            |            | LPP、NBSSP、UGP                                    |             |
| 5    | Session      | 会话层     | 应用层     | 应用层     | SSL、TLS、RPC                                      |             |
|      |              |            |            |            | socket                                             |             |
| 4    | Transport    | 传输层     | 传输层     | 传输层     | TCP、UDP、UGP                                      | LVS负载均衡 |
| 3    | Network      | 网络层     | 网络层     | 网络层     | IP、PIP、ICMP、IGMP、OSPF                          |             |
| 2    | DataLink     | 数据链路层 | 数据链路层 |            | 以太网、网卡、交换机、PPTP、L2TP、ARP、ATMP        |             |
| 1    | Physical     | 物理层     | 物理层     | 网络接口层 | 物理线路、光纤、中继器、集线器、双绞线             |             |

### 奇妙比喻

| 协议         | 比喻一 | 比喻二 |
| ------------ | ------ | ------ |
| http         | 货物   | 轿车   |
| 封装的socket |        | 发动机 |
| tcp、udp     | 卡车   |        |
| ip           | 公路   |        |

- socket和七层模型没什么直接关系
- http一般是短连接，每次请求都需要进行三次握手
- http也有长连接场景，比如长轮训
- http可以通过keep-live参数复用连接
- socket是长连接
- 应用层和TCP/IP交互时，需要遵循后者的协议，socket是对后者的简化封装