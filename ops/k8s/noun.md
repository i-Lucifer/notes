## 重要名词

| 名词       | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| Cluster    |                                                              |
| Master     | 调度(管理)+干活，可以多主                                    |
| Node       | 干活(运营容器)                                               |
| Pod        | 最小工作单元，方便管理，资源共享(ip port 存储)，理解为一个Docker-compose，容器组 |
| Controller | 运行Pod交给Controller，描述了Pod的特征，比如几个副本，比如在哪个Node运行 |
| Service    | 访问Pod交给Service，Pod被销毁时，IP会发生变化，Service解决这个问题，统一向外提供IP |
| Namespace  | 命名空间，不同项目，资源隔离。kube-system空间(系统资源类的)，default空间(未指定空间时) |

## Controller

| 类型         | 说明                                                         |
| ------------ | ------------------------------------------------------------ |
| Deployment   | 可以管理Pod的多个副本，确保Pod按期望执行                     |
| ReplicaSet   | 实现Pod多副本管理，Deployment会自动创建ReplicaSet，一般不直接使用此类型 |
| DaemonSet    | 每个Node最多运行一个Pod副本场景                              |
| StatefuleSet | 保持Pod名称不变，保证副本按固定的顺序启动，更新或删除        |
| Job          | 运行结束就删除，一次性任务                                   |

