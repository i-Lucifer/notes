目录

[[TOC]]

## Namespace 基础概念

- Linux Namespace 是 Kernel的一个功能(IO多路复用里的epoll模型，好像也是内核功能吧)
- 可以隔离系统资源、PID(Process ID)、User ID、Network等。像chroot允许把一个目录变成根目录(不知道这是啥，忽略这个例子吧)
- 场景举例 (UserID)
  - 高性能服务器给多个应用使用时，可能产生误操作。
  - 可以隔离权限，防止误操作
  - 但是有些应用需要root权限
  - Namespace可以做到UID级别的隔离，为UID为n(假如是5)虚拟化出来一个Namespace，在这个Namespace，用户具有root权限。

- Linux一共实现了6种不同类型的Namespace

  | 类型                         | 系统调用参数(请忽略第二个下划线，为阅读方便添加) | 内核版本 |
  | ---------------------------- | ------------------------------------------------ | -------- |
  | Mount N(Namespace缩写，下同) | CLONE_NEW_NS                                     | 2.4.19   |
  | UTS N                        | CLONE_NEW_UTS                                    | 2.6.19   |
  | IPC N                        | CLONE_NEW_IPC                                    | 2.6.19   |
  | PID N                        | CLONE_NEW_PID                                    | 2.6.24   |
  | Network N                    | CLONE_NEW_NET                                    | 2.6.29   |
  | User N                       | CLONE_NEW_USER                                   | 3.8      |

- Namespace的Api主要使用如下3个系统调用

  | api       | 说明                                                         |
  | --------- | ------------------------------------------------------------ |
  | clone()   | 创建新进程，根据**系统调用参数**创建不同类型的Namespace，子进程也会被在此Namespace中 |
  | unshare() | 将进程移出某个Namespace                                      |
  | setns()   | 将进程加入某个Namespace                                      |

  
## 六种Namespace介绍
### UTS Namespace
- 主要用来隔离nodename和domainname两个系统标识。(暂时不理解这两个名词)
- 在UTS里，每个Namespace允许有自己的hostname。(到这里大概知道和hostname有关即可)
- 隐藏书中用go实现UTS，后续有需要另开文章。

### IPC Namespace
- IPC 在这里应该是指[进程间通讯]() 挖坑 待填
- 隔离System V IPC和POSIX message queue (可以暂时忽略这两个名词)
- 每个IPC Namespace都有自己的System V IPC和POSIX message queue
- 隐藏书中代码

### PID Namespace
- 隔离进程ID
- 使用ps -ef命令，在容器内看到前台运行的那个进程的PID为一，而宿主机上有不同的PID
- 隐藏书中代码

### Mount Namespace
- 第一个实现的Namespace，系统调用NEW_NS是New Namespace的缩写。
- 隔离各个进程的挂载点视图(知识盲区)，简单来说就是文件系统隔离
- 包含chroot()功能，更加灵活

### User Namespace
- 隔离用户和用户组ID
- 宿主机非root权限、Namespace内可以有root权限
### Network Namespace
- 隔离网络设备、IP地址、端口等
- 可以让每个容器有自己独立的(虚拟)网络设备
- 宿主机搭建网桥后(可以理解为路由)，容器间可以相互通讯
