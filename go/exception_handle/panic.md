## panic
- os.Exit()与panic对比
    - os.EXit()立即关闭程序，后面的不再执行，和kill -9比较类似
    - panic()，后面可以执行defer，也可以配合recover进行恢复
- 机制
    - panic会递归执行携程中的所有defer、与函数正常退出一致
    - panic不会处理其他携程中的defer
    - 当前协程中的defer处理完成后，程序退出