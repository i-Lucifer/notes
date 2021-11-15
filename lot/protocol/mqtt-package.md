[TOC]

### MQTT数据包格式

#### 格式简介

MQTT使用二进制数据包

- 固定头 Fix Header，这里的固定，是指所有数据包中都有固定头，而不是字节长度固定，包括以下三部分
  - 数据包类型
  - 数据包标识
  - 数据包剩余长度 = 可变头长度+消息体长度
- 可变头 Variable Header，部分数据包类型中存在可变头
- 消息体 Payload，部分数据包类型中存在消息体，消息的具体数据

#### 固定头 数据包剩余长度

- 字节2里的，高位7，如果值为1，表示下面一个字节也是数据标记，最多存在4组数据剩余长度

<table>
  <tr>
    <td>说明</td>
    <td>Bit</td>
    <td>高7位</td>
    <td>6</td>
    <td>5</td>
    <td>4</td>
    <td>3</td>
    <td>2</td>
    <td>1</td>
    <td>低0位</td>
  </tr>
  <tr>
    <td>固定头</td>
    <td>字节1</td>
    <td colspan="4">数据包类型</td>
    <td colspan="4">数据包标识</td>
  </tr>
  <tr>
    <td>固定头</td>
    <td>字节2 数据包剩余长度</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
  </tr>
  <tr>
    <td>固定头</td>
    <td>字节3-5 数据包剩余长度</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
  </tr>
</table>

- 数据包剩余长度 单位换算
  - 高位7被用作标记是否还有下一个字节，低位0-6公7个位置标记数据长度，所以是2^7

| 字节数 | 标识最小长度 | 标识最大长度          | 换算                             |
| ------ | ------------ | --------------------- | -------------------------------- |
| 1      | 0            | (2^7)-1=127           | 128b                             |
| 2      | 128          | (2^7)^2-1=16 383      | 16kb                             |
| 3      | 16384        | (2^7)^3-1=2 097 151   | 2mb                              |
| 4      | 2097152      | (2^7)^4-1=268 435 455 | 256mb MQTT协议传输数据的最大长度 |

#### 数据包类型

数据包类型占据高4位，2^4=16，最多表示16中类型的数据包

| 值   | 名称 请忽略下划线 | 方向           | 描述               |
| ---- | ----------------- | -------------- | ------------------ |
| 0    | Reserved          | 不可用         | 保留位             |
| 1    | CONNECT           | Client到Broker | 请求连接           |
| 2    | CONN_ACK          | Broker到Client | 连接确认 ACK       |
|      |                   |                |                    |
| 3    | PUBLISH           | 双向           | 发布消息           |
| 4    | PUB_ACK           | 双向           | 发布ACK            |
| 5    | PUB_REC           | 双向           | 发布收到           |
| 6    | PUB_REL           | 双向           | 发布释放           |
| 7    | PUB_COMP          | 双向           | 发布完成           |
|      |                   |                |                    |
| 8    | SUB_SCRIBE        | Client到Broker | Client请求订阅     |
| 9    | SUB_ACK           | Broker到Client | 订阅确认           |
| 10   | UN_SUB_SCRIBE     | Client到Broker | Client请求取消订阅 |
| 11   | UN_SUB_ACK        | Broker到Client | 取消订阅确认       |
|      |                   |                |                    |
| 12   | PING_REO          | Client到Broker | Ping请求           |
| 13   | PING_RESP         | Broker到Client | Ping应答           |
| 14   | DIS_CONNECT       | Client到Broker | Client主动中断连接 |
| 15   | Reserved          | 不可用         | 保留位             |

#### 数据包标识位

- 前面的数据包类型，大部分都不需要标识位，这里只列一下需要标识位的。

- 发布数据包中，用到了三种标识位，QoS占用两个位。
  - DUP
  - QoS 消息质量 最多发送一次 最少发送一次 恰好发送一次
    RETAIN

| 数据包  | 标识位         | Bit3 | 2    | 1    | Bit0   |
| ------- | -------------- | ---- | ---- | ---- | ------ |
| PUBLISH | MQTT 3.1.1使用 | DUP  | QoS  | QoS  | RETAIN |

### MQTT数据包详解
#### 连接相关
##### 连接数据包 CONNECT

- 请求头

<table>
  <tr>
    <td>说明</td>
    <td>Bit</td>
    <td>7</td>
    <td>6</td>
    <td>5</td>
    <td>4</td>
    <td>3</td>
    <td>2</td>
    <td>1</td>
    <td>0</td>
  </tr>
  <tr>
    <td>固定头</td>
    <td>字节1</td>
    <td colspan="4">1(CONNECT)</td>
    <td colspan="4">保留信息</td>
  </tr>
  <tr>
    <td>固定头</td>
    <td>字节2</td>
    <td colspan="8">数据包剩余长度</td>
  </tr>
  <tr>
    <td>可变头</td>
    <td>字节1 固定前缀</td>
    <td colspan="8">0</td>
  </tr>
  <tr>
    <td>可变头</td>
    <td>字节2 固定前缀</td>
    <td colspan="8">4</td>
  </tr>
  <tr>
    <td>可变头</td>
    <td>字节3-6 协议名称</td>
    <td colspan="8">四个字节分别对应M Q T T，如果协议名称不正确，broker会断开Client连接</td>
  </tr>
  <tr>
    <td>可变头</td>
    <td>字节7 协议版本</td>
    <td colspan="8">3.1.1版本的固定值为4</td>
  </tr>
  <tr>
    <td>可变头</td>
    <td>字节8 连接标识</td>
    <td>用户名</td>
    <td>密码</td>
    <td>遗愿消息Retain</td>
    <td colspan="2">遗愿消息QoS</td>
    <td>遗愿标识</td>
    <td>会话清除</td>
    <td>保留位</td>
  </tr>
  <tr>
    <td>可变头</td>
    <td>字节9 Keepalive</td>
    <td colspan="8">Keepalive 高8位 心跳间隔 保活设置 以秒为单位</td>
  </tr>
  <tr>
    <td>可变头</td>
    <td>字节10 Keepalive</td>
    <td colspan="8">Keepalive 低8位 (2^8)^2=65536s=18小时左右</td>
  </tr>
</table>
- 消息体

  - 两个固定字节的前缀，用来表示各个字段的数据长度

  - 固定字段 客户端标识符 Client Identifier 后面简称ID

  - 四个可选字段，由可变头中的连接标识控制


| 说明   | 字节          | 位0-7                                                        |
| ------ | ------------- | ------------------------------------------------------------ |
| 消息体 | 前缀字节1     | 前缀字节 数据长度高8位 标识每个字段的数据长度                |
| 消息体 | 前缀字节1     | 前缀字节 数据长度低8位 比如标识下面的ID所占的字节长度，长度一般为1-23 |
| 消息体 | 字段 ID       | 客户端标识符 Client Identifier 后面简称ID，建议UUID，或者设备ID，如果客户端传空，Broker可生成 |
| 消息体 | 字段 用户密码 | Broker根据可选头判断是否需要验证用户和密码，不同Client必须不同的ID，但是可以用同一个用户 |
| 消息体 | 字段 遗愿主题 | 遗愿标识如果为1，消息体中包含遗愿<font color="red">主题</font>，Client非正常终端，Broker向指定遗愿主题发遗愿消息 |
| 消息体 | 字段 遗愿消息 | 遗愿标识如果为1，消息体中包含遗愿<font color="red">消息</font> |
| 消息体 | 字段 遗愿QoS  | 书中未做详细说明                                             |

##### 连接确认数据包 CONN_ACK

##### 关闭连接数据包 DIS_CONNECT

#### 发布订阅

##### 发布 PUBLISH

##### 发布ACK PUB_ACK PUB_REC PUB_REL PUB_COM

##### 订阅 SUB_SCRIBE SUB_ACK

##### 取消订阅 UN_SUB_SCRIBE UN_SUB_ACK

#### 连接保活Keepalive

##### PingREQ

##### PingRESP

