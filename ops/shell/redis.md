```
#!/bin/bash

for ((i=0;i<100;i++))
do
echo -en "helloworld" | redis-cli -a root -x set name $i >>redis.log
done
```

- 解读
    - for循环100次
    - do开始 down结束
    - 控制台输出
        - 调用redis-cli 加参数 执行一个完整的命令，并输出日志