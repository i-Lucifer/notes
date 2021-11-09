## 基本功能

### 描述

- 物联网云平台
- 使用go语言，微服务
- 支持多种设备，用户，App
- 支持多协议，MQTT，HTTP，WebSocket，CoAP
  - 南向接口面向设备
  - 北向接口面向应用
- 提供完整的从设备到平台到应用的解决方案

## 服务

- 系统管理
- 设备管理 - 南向接口
- 应用管理 - 北向接口

- 用户管理
- 数据存储 - 时序数据库
- 消息处理 - 事件中心总线NATS(消息队列)

## 消息扭转与协议转换

- 设备与应用通讯
- 设备与设备通讯
- 应用与应用通讯

## 系统管理

- 用户 (管理员、应用创建者、开发人员) 权限管理

- 客户端 (设备和应用)

- 设备

  - 低功耗，低配置，使用MQTT或者CoAP协议，加密使用DTLS的一些设备
  - 中高配置，使用WebSocket或者Http协议

- 应用

  - 主要使用HTTP或者WebSocket，很少使用MQTT

- 通道(连接)

  - 通讯模型，双向消息流
  - 比如 MQTT的topics和topic

  - 经过通过到的消息会被持久化（性能怎么说）

- 设备管理

  - 设备模型
  - 设备维护者
    - 连接了多少设备
    - 分布在哪里
    - 版本
    - 电池状态
    - 序列号
    - 发送指令
    - 打开或者关闭
    - 升级
    - 分组与访问权限

- 用户和应用管理

## 时序数据库

- Cassandra

## 时间处理引擎

Complex Event Processing (CEP)

## 事件处理及系统Dashboard

### SenML

### Mainflux Message

### Normalization

### Security

#### Authentication (AuthX)

### Authorization (AuthZ)