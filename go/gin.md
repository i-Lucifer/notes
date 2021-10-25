# goweb框架

- web工具 net/http
- 路由 gin
- 读取配置
- 记录日志
- 中间件







### gin

#### 初始化

```go
r := gin.Default()
```

#### 路由

- GET请求

```go
r.GET("/ping", func(c *gin.Context) {
	// 内容
})
```

- POST请求

```go
r.POST("/ping", func(c *gin.Context) {
	// 内容
})
```



#### 输出

- 输出一个json格式 

```json
c.JSON(200, gin.H{
    "key": "val",
})
```

- 输出一个字符串

```go
c.Writer.WriteString("Hello")
```

#### 运行

- 运行默认8080端口

```go
r.Run()
```

- 运行指定端口

```go
r.Run(":8888")
```



#### 返回html

```go
r.LoadHTMLGlob("public/html/*")  // 加载所有静态html

// 设置路由 读取模板 传递变量
r.GET("/html", func(c *gin.Context) {
  c.HTML(200, "main.html", gin.H{"Title": "Hello Html"})
})

r.GET("/htm", func(c *gin.Context) {
  c.HTML(http.StatusOK, "main.html", gin.H{"Title": "Hello Htm"})
})
```

#### json和html对比

```go
c.JSON(200, 
    gin.H{
        "key": "val",
})

c.HTML(200, 
    "main.html",    // 比json多读取一个html文件
     gin.H{
         "Title": "Hello Html"
})
```

#### 路由分组

- 访问 url/组名/路由
- 127.0.0.1:8080/g1/say

```go
	g1 := r.Group("g1")
	g1.GET("/say", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"Hello": "say g1",
		})
	})
```

