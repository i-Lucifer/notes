## 危险命令
- 危险命令可以通过 redis.conf 禁用
```
rename-command keys     ""
rename-command flushall ""
rename-command flushdb  ""
rename-command config   ""
```
- 危险命令说明
  - keys命令 会阻塞线程，可以使用scan代替此命令
  - config命令 可以修改redis配置项
  - flushdb 会清空数据库 只删除当前数据库
  - flushall 会清空数据库 删除所有数据库

- flushdb/flushall急救

  - 调整持久化重写参数，不允许aof重写

    ```
    config set auto-aof-rewrite-percentage 1000
    config set auto-aof-rewrite-min-size 100000000000
    ```

  - 删除aof中的flash命令

    ```
    *1
    $8
    FLUSHALL
    ```

  - 检查aof文件状态

    ```
    redis-check-aof appendonly_6379.aof
    ```

  - 重启