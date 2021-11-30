---
date: "2021-10-25T08:36:54-07:00"
title: "队列"
---

- 生产者与消费者
```go
package main
import (
	"fmt"
	"time"
)
//生产者
func Producer(begin, end int, queue chan<- int) {
	for i:= begin ; i < end ; i++ {
		fmt.Println("produce:", i)
		queue <- i
	}
}
//消费者
func Consumer(queue <-chan int) {
	for val := range queue  { //当前的消费者循环消费
		fmt.Println("consume:", val)
	}
}
func main() {
	queue := make(chan int)
	defer close(queue)
	for i := 0; i < 3; i++ {
		go Producer(i * 5, (i+1) * 5, queue) //多个生产者
	}
	go Consumer(queue) //单个消费者
	time.Sleep(time.Second) // 避免主 goroutine 结束程序
}
```

