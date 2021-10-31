## 隔离文件

- chroot小知识
  - 1979年Unix7提供chroot命令（Change root），限制文件访问
  - 1991年，监控黑客的Chroot监狱诞生，突破chroot限制的方法叫越狱
  - FreeBSD 4.0重新实现chroot，作为系统中进程沙箱隔离的基础
  - 苹果基于FreeBSD开发ios系统，所以越过ios沙箱机制提起root权限安装程序，称为越狱

- pivot_root小知识
  - 2000年，Linux Kernel 2.3.41引入pivot_root技术实现文件隔离（切换根系统文件）
  - LXC，docker也优先使用pivot_root来实现根文件系统切换
- 补充
  - 文件隔离(chroot、pivot_root)只能隔离文件，Unix哲学万物皆文件，但只是哲学
  - 硬件资源和操作系统资源，存在大量非文件的操作入口，所以需要新的隔离手段(见Namesapce和cgroups章节)
  - 硬件层面资源
    - 磁盘
    - 网络
    - 内存
    - CPU
  - 操作系统层面资源
    - Unix分时
    - 进程ID
    - 用户ID
    - 进程间通讯

