## 程序优化

### 类比

| 程序术语       | 生活术语 |
| -------------- | -------- |
| 数据库         | 厨师     |
| 进程 线程 协程 | 店小儿   |

- 总结
  - 店铺提升QPS的核心本质，在于厨师能多快出餐，不论店小二节点了多少顾客，出餐速度慢，QPS难提高。
  - 这里的厨师，不单单指数据库，也可以指一切下游服务器。
  - 提升下游服务能力，有两种。
    - 提升下游服务能力
    - 异步，不直接和低服务能理解的程序打交道。