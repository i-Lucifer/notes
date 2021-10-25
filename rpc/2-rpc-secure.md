[TOC]

## rpc问题

- 角色
  - 服务端
  - 客户端
  - 规范、标准
- 不利于维护，要制定如下规范：
  - 服务名
  - 接口，规范参数类型

## 安全的rpc

- 这里的安全不是通讯需要加密、而是避免语法错误

```bash
.
├── client.go
├── common
│   ├── client.go
│   ├── common.go  # 标准 服务名 接口 封装的意义在于 服务名不需要手写，必须使用常量
│   └── server.go  # 稍微封装了一下 rpc.RegisterName
├── go.mod
├── readme.md
└── server.go      # 稍微改动，进行持续监听
```

### 公共

- common.go
  - 定义了一个常量
  - 定义了一个接口

```go
package common

const HelloServiceName = "path/to/pkg.HelloService" // HelloServiceName 服务名

type HelloServiceInterface = interface {  // 接口的类型别名
  // 方法列表
	Hello(request string, reply *string) error // 这个在rpc的入门篇里已经看过了
}
```

### 服务层

接下来，我们先对service进行改造

- 实现接口，也就是之前rpc的Hello结构体

```go
type HelloService struct{}

func (p *HelloService) Hello(request string, reply *string) error {
	*reply = "hello:" + request
	return nil
}
```

- 将rpc.RegisterName进行封装

```go
// 参数是上面接口的实现，也就是传递一个结构体即可
func RegisterHelloService(svc HelloServiceInterface) error {
	return rpc.RegisterName(HelloServiceName, svc)  // 参数一是服务名 即上面的常量
}
```

- 另外我们还需要更够持续监听客户端发来的消息，代码如下

```go
func main() {
	common.RegisterHelloService(new(HelloService))  // rpc.RegisterName 封装注册

	listener, err := net.Listen("tcp", ":1234")
	if err != nil {
		log.Fatal(err)
	}
	
	for {  // 循环接收并发送
		conn, err := listener.Accept()
		if err != nil {
			log.Fatal(err)
		}
		go rpc.ServeConn(conn)
	}
}
```

### 客户端

- 在上节rpc中，我们注册的服务名是HelloService，客户端调用时传递HelloService.Hello
- 在本节rpc中，我们注册的服务名是HelloServiceName常量，调用时应该传递 HelloServiceName+".Hello"

```go
p.Client.Call(HelloServiceName+".Hello", request, reply)
```

- 更多的不再讲解，看书吧。