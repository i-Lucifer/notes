## 管道特性
- 管道初始化
- 管道容量和长度(缓冲区)
- 管道读取阻塞
- 管道写入阻塞

## 管道实现原理

### 数据结构

- 管道的底层结构是循环队列
- 下面的数据结构位于/src/runtime/chan.go

```go
type hchan struct {
	qcount   uint           // len的取值属性，剩余的元素数量
	dataqsiz uint           // cap的取值对象，循环队列长度，可存放的元素个数
	buf      unsafe.Pointer // 循环队列指针
  
	elemsize uint16					// 每个元素的大小
	closed   uint32				  // 关闭状态  
	elemtype *_type 			  // 元素类型
  
	sendx    uint   // 队列下标，指示下一个元素写入时，存放队列的位置，队列的尾
	recvx    uint   // 队列下标，指示下一个元素读取时，读取队列的位置，队列的头
  
  recvq    waitq  // 等待读消息的协程队列，缓冲区无值时使用
	sendq    waitq  // 等待写消息的协程队列，缓冲区无剩余空间时使用

	lock mutex      // 互斥锁，chan不允许并发读写
}

type waitq struct {
	first *sudog
	last  *sudog
}
```

## 管道操作

- 创建
- 写入
- 读取
- 关闭

## 常见用法

- 单向管道
- select
- for-range 循环消费