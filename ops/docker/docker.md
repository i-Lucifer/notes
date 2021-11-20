## 容器与虚拟机

| 对比   | 容器                                                         | 虚拟机                                         |
| ------ | ------------------------------------------------------------ | ---------------------------------------------- |
| 隔离性 | 共享系统内核和组件，受到攻击会蔓延到其他容器                 | 系统资源完全隔离，如果虚拟机出现问题，不会蔓延 |
| 性能   | 容器更多网络链接，转发，数据交互，高并发场景下，容器可能成为性能瓶颈 | 虚拟机同样有此问题                             |
| 存储   | 宿主机或者网络磁盘都会数据交互                               |                                                |
| 依赖   | linux容器和windows容器不能互相移植                           | 只要hypervisor合适，可以移植                   |

## 适合场景

- 微服务，应用程序



## Docker

- 架构与组件

- 基础技术
    > 隔离文件这部分，主要来自《凤凰架构》容器章节
    - [chroot与pivot_root](./../../book/linux/chroot.md)
    > Docker使用了Linux Namespace和Cgourps虚拟化工具，以下三篇文章介绍了这些技术，主要为《自己动手写docker》的读书总结，如有更新，会在此处注释。
    - [Linux Namespace](./../../book/linux/namespace.md) <font color=Red>隔离</font>六种资源
    - [Linux Cgroups](./../../book/linux/cgroups.md)      Control Gruops <font color=Red>限制</font>和<font color=Red>监控</font>资源
    - Union File System<!-- (./../../book/linux/file_system.md) --> 联合文件系统、文件挂载、读写等

- 容器使用
    - [初体验](./run.md)
    - 容器
    - 镜像
    - 仓库


- Docker网络

- Dockerfile
- Docker Compose

<!--
- Docker Machine
- Docker Swarm
-->