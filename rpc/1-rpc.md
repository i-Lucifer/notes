[TOC]

## rpc入门

### [仓库地址](http://ali.io:3000/go-advanced/rpc.git)

### rpc目录结构

```bash
.
├── client.go      ## 类似客户端，这个客户端可以是js，可以是java，可以是go
├── go.mod
├── readme.md
├── server.go      ## 类似路由和接口 或者main.go
└── service
    └── hello.go   ## 类似控制器
```

### 类比控制器

- http请求中的控制器
  - 响应参数是 值类型
  - 请求参数是 指针类型

```go
func Hello(w http.ResponseWriter, r *http.Request){
	// TODO
}
```

- hello.go rpc请求中的控制器，通过类比一下两段代码，我们发现，十分类似
  - 请求参数是 值类型
  - 响应参数是 指针类型
  - 需要返回一个错误信息

```go
package service

type HelloService struct{}

func (p *HelloService) Hello(request string, reply *string) error {
	*reply = "hello:" + request
	return nil
}
```

### 类比路由和服务端

- http请求中的路由

```go
func main(){
	http.HandleFunc("/", welcome.Welcome)  // 注册路由

	err := http.ListenAndServe("8080", nil) // 启动服务 监听端口
	if err != nil {
    panic(err)
	}
}
```

- rpc中的路由

```go
func main() {
	rpc.RegisterName("HelloService", new(service.HelloService))  // 注册路由 注册rpc

	listener, err := net.Listen("tcp", ":1234")  //  初始化服务 监听端口

	conn, err := listener.Accept()  // 持续监听 客户端发来的消息

	if err != nil {
		log.Fatal(err)
	}
	rpc.ServeConn(conn)  // 启动服务? 更像是返回信息
}
```

- 区别
  - http请求进来之后，还能为下一次请求服务
  - rcp请求返回信息之后，就退出了程序，待改进。

### 类比客户端

```go
func main() {
	client, err := rpc.Dial("tcp", "localhost:1234")   // 设置请求的url
	if err != nil {
		log.Fatal(err)
	}

	var reply string // 得到的参数
	err = client.Call("HelloService.Hello", "hello", &reply) // 请求的rpc方法，或者路由
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(reply)
}
```

