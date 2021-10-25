- 连接

  - 外部直接通过Db访问数据库，存在Db被重新赋值的风险

  ```go
  var Db *sql.DB
  
  func init() {
  	var err error
  	Db, err = sql.Open("postgres", "dbname=chitchat")
  
  	if err != nil {
  		log.Fatal(err)
  	}
  	return
  }
  ```

- 查询操作

  - 方式一
    - Prepare 预处理
    - QueryRow 执行查询

  ```go
  sql := "insert into sessions (uuid,email,user_id,created_at) values($1,$2,$3,$4) returning id,uuid,email,user_id,created_at"
  	stmt, err := Db.Prepare(sql)
  	if err != nil {
  		return
  	}
  	defer stmt.Close()
  	err = stmt.QueryRow(CreateUUID(), user.Email, user.Id, time.Now()).Scan(&session.Id, &session.Uuid, &session.Email, &session.UserId, &session.CreatedAt)
  	return
  ```

  - 方式二

    ```
    
    ```

- 增删改操作

