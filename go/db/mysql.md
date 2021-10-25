- 连接数据库

  - 通过DBConn方法访问数据库，这样db没有被重置的风险

  ```go
  var db *sql.DB
  
  func init() {
  	var err error
  	db, err = sql.Open("mysql", "root:root@tcp(127.0.0.1:23306)/nas?charset=utf8")
  
  	if err != nil {
  		fmt.Println(err)
  		os.Exit(10000)
  	}
  	db.SetMaxOpenConns(1000)
  	err = db.Ping()
  	if err != nil {
  		fmt.Println(err)
  		os.Exit(10001)
  	}
  }
  
  func DBConn() *sql.DB {
  	return db
  }
  ```

  