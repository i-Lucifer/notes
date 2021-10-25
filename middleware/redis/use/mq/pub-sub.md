## ## 发布订阅

### 订阅端

```bash
subscribe chat

Reading messages... (press Ctrl-C to quit)
# 新消息 服务器返回的 订阅结果 如果订阅多个窗口 会返回多个 1) 2) 3)
1) "subscribe"
2) "chat"
3) (integer) 1

# 新消息
1) "message"
2) "chat"
3) "hello"
```

### 发布端

```bash
publish chat hello

# 发布通知到订阅数
(integer) 3
```

### 其他命令

- 状态命令

  ```bash
  # 通道活跃状态 活跃的通道列表(至少有一个订阅者)
  pubsub channels [*wechat]
  
  # 查看chat通道的订阅者数量
  pubsub numsub chat
  
  # 查看所有订阅模式的客户端数总和
  pubsub numpat
  ```

  

- 批量订阅、退订、批量退订

```bash
# 批量订阅 订阅以chat开头和以chat结尾的所有通道
psubscribe *chat *chat 

# 退订和批量退订 crtl+c就退出退订了，这两条有什么含义？
unsubscribe
punsubscribe
```

### 场景

- 消息队列 多消费者