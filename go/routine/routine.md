[TOC]

[[TOC]]

## 协程

## 调度模型
### 线程模型
- 线程可分为用户线程和内核线程
- 用户线程由用户创建、同步和销毁
- 内核线程由内核管理
- 根据用户线程管理方式的不同，分三种线程模型

| 模型 | 对应关系                                       | 优点                              | 缺点                    |
| ---- | ---------------------------------------------- | --------------------------------- | ----------------------- |
| N:1  | N个用户线程运行在一个内核线程中                | 用户线程上下文切换快              | 无法充分利用CPU多核算力 |
| 1:1  | 1个用户线程对应一个内核县县城                  | 充分利用CPU算力                   | 线程上下文切换比较慢    |
| M:N  | 前两种组合，M和用户线程(协程)，运行在N和线程中 | 充分利用CPU算力，协程上下文切换快 | 调度算法复杂            |

### Go调度器模型

GPM

- M machine 工作线程，由操作系统调度、一般稍大于P，除了运行go代码，还有runtime的其他内置任务要处理
- P processor 处理器    启动时决定，默认等于CPU核数，runtime.GO_MAX_PROCS可以指定P个数
- G goroutine go协程

调度模型

- 早期、全局run_queues、要加锁、影响并发执行效率
- 现版本、P拥有单独的run_queues队列、共有全局run_queues队列
- 协程G的子协程、默认在同一个run_queues，也就是由同一个P处理
  - 如果队列满了，就放到全局队列
- P周期性的从全局队列取任务，防止全局的任务饿死

## 调度策略
- 队列轮转
- 系统调用
- 工作量窃取
- 抢占式调度 时间片轮转
  - 抢占式协程池
  - 调度式携程池

- P对性能的影响

