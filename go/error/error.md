## 源代码

```go
package errors

// new error时得到的是地址
func New(text string) error {
	return &errorString{text}
}

// 结构体包裹字符串
// 最终返回指针
type errorString struct {
	s string
}

// 可以根据指针返回字符串
func (e *errorString) Error() string {
	return e.s
}
```



## 标准库的error为什么返回指针

- 巧妙
- 避免A包的error.New("EOF")和B包的error.New("EOF")相等
  - 字符串相等‘
  - 但是指针不相等
  - 避免了一些未知的bug



## 为什么用error而不是用exception

- c、单返回值 返回int表示代表成功与否
- c++ 异常 不知道具体会返回什么异常、优秀的思想
- java 异常、会提前告知异常
- 异常是个好东西，但是被滥用、大家都喜欢偷懒。
- go 多返回值，返回 要返回的信息+状态



## panic和exception

- 任何地方出现了panic，程序就会挂掉，所以是必须要解决的
- exception一般会造成数据不一致



## panic不可恢复的情况

- panic可以被上级捕捉
- go routine中的panic不能被上级捕捉



## main强依赖弱依赖panic

- 强依赖
- 弱依赖

强依赖示例 比如redis能连接，mysql不能连接，此时服务该启动吗？

- 读多写少时，可以先启动
- 写多时，不该启动
- 此时redis是强依赖，mysql是弱依赖

弱依赖示例 grpc服务端不可用时，

- 客户端panic
- 客户端重连



## 资源找不到error辩证

- 第一种 值返回nil
- 第二种 error返回消息  缺点 不灵活
- 第三中 panic 极其不推荐，只有真正异常的，不可恢复的错误一般采用这个，比如索引越界，比如栈溢出