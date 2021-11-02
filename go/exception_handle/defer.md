## defer
### defer的行为规则
- defer后的延迟函数，在defer语句出现时，参数就已经确定了
    - 参数值是copy值
    - 如果传递的值是指针，则会将指针copy一份
- defer后的延迟函数，按后进先出(栈结构)的顺序执行，即先出现的defer后执行
- defer后的延迟函数，可能会操作主函数的具名返回值 ```func GetName() (name string){}```
    - return 不是原子操作
        - return 第一步，将返回值copy到栈中
        - defer 可能会修改栈中的值
        - return 第二步，执行跳转
### 使用场景
- 释放资源
    - 释放锁、关闭文件句柄、数据库连接、停止定时器
- 流程控制
    - wg.Wait()
- 异常处理
    - derver recover配合消除panic