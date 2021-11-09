[TOC]
[[TOC]]

## 前提知识

- cGroups的三个组件
  - cgroup 进程分组
  - subsystem 资源控制
  - hiererchy cgroup继承树(面向对象的类)

## cGroups命令行实践

先安装一些会用到的工具

```
sudo apt-get install -y cgroup-tools stress tree htop
```

| 工具         | 作用             |
| ------------ | ---------------- |
| cgroup-tools | cgroup相关的工具 |
| stress       | 压力测试工具     |
| tree         | 目录树状结构     |
| htop         | top的升级版本    |

## 查看支持的 subsystem

```bash
lssubsys -a
```

> cpuset
> cpu,cpuacct
> blkio
> memory
> devices
> freezer
> net_cls,net_prio
> perf_event
> hugetlb
> pids
> rdma

## 挂载hierarchy(cgroup树)

### 创建并挂载

```bash
mkdir cgroup-test
sudo mount -t cgroup -o none,name=cgroup-test cgroup-test ./cgroup-test  # 挂载
cd cgroup-test
tree   # 查看目录，发现自动生成了一些文件
```

> .
> ├── cgroup.clone_children
> ├── cgroup.procs
> ├── cgroup.sane_behavior
> ├── notify_on_release
> ├── release_agent
> └── tasks

### 扩展子group

```bash
cd cgroup-test
sudo mkdir cgroup-1
sudo mkdir cgroup-2
tree   # 查看目录，发现又生成了一些文件，生成的文件，和上级目录的文件几乎一致，基本是继承来的
```

```bash
.
├── cgroup-1
│   ├── cgroup.clone_children
│   ├── cgroup.procs
│   ├── notify_on_release
│   └── tasks
├── cgroup-2
│   ├── cgroup.clone_children
│   ├── cgroup.procs
│   ├── notify_on_release
│   └── tasks
├── cgroup.clone_children
├── cgroup.procs
├── cgroup.sane_behavior
├── notify_on_release
├── release_agent
└── tasks

2 directories, 14 files
```

### 添加移动进程验证cgroup

- 获取进程号

```bash
echo $$   
# 查看当前终端进程，这里得到的是32215
cat /proc/32215/cgroup
```
- 验证

| 直接查看<br/>cat /proc/32215/cgroup                          | 移动进程之后查看<br/>cd ./cgroup-1<br/>sudo sh -c "echo $$ >> tasks"<br/>cat /proc/32215/cgroup |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| 13:name=<font color=Red>cgroup-test:/</font><br/>12:devices:/user.slice<br/>11:hugetlb:/<br/>10:freezer:/<br/>9:memory:/user.slice/user-1000.slice/user@1000.service<br/>8:blkio:/<br/>7:pids:/user.slice/user-1000.slice/user@1000.service<br/>6:perf_event:/<br/>5:net_cls,net_prio:/<br/>4:cpuset:/<br/>3:rdma:/<br/>2:cpu,cpuacct:/<br/>1:name=systemd:/user.slice/user-1000.slice/user@1000.service/apps.slice/apps-org.gnome.Terminal.slice/vte-spawn-9ba47e31-1822-4f7e-b714-f4d7b1394a63.scope<br/>0::/user.slice/user-1000.slice/user@1000.service/apps.slice/apps-org.gnome.Terminal.slice/vte-spawn-9ba47e31-1822-4f7e-b714-f4d7b1394a63.scope | 13:name=<font color=Red>cgroup-test:/cgroup-1</font><br/>12:devices:/user.slice<br/>11:hugetlb:/<br/>10:freezer:/<br/>9:memory:/user.slice/user-1000.slice/user@1000.service<br/>8:blkio:/<br/>7:pids:/user.slice/user-1000.slice/user@1000.service<br/>6:perf_event:/<br/>5:net_cls,net_prio:/<br/>4:cpuset:/<br/>3:rdma:/<br/>2:cpu,cpuacct:/<br/>1:name=systemd:/user.slice/user-1000.slice/user@1000.service/apps.slice/apps-org.gnome.Terminal.slice/vte-spawn-9ba47e31-1822-4f7e-b714-f4d7b1394a63.scope<br/>0::/user.slice/user-1000.slice/user@1000.service/apps.slice/apps-org.gnome.Terminal.slice/vte-spawn-9ba47e31-1822-4f7e-b714-f4d7b1394a63.scope |

## subsystem限制资源
### 使用系统为subsystem默认分配的hierarchy(以memory示例)
```bash
mount | grep memory
```

> 得到如下结果，可以看到，如下红色目录是挂载了memory subsystem的hierarchy上
> cgroup on <font color=Red>/sys/fs/cgroup/memory</font> type cgroup (rw,nosuid,nodev,noexec,relatime,memory)

### 限制内存

| 直接对内存压测、见第一行结果                                 | 先限制内存再压测、见第二行结果                               |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| cd /sys/fs/cgroup/memory<br/>stress --vm-bytes 200m --vm-keep -m 1<br/>top | sudo mkdir test-limit-memory && cd test-limit-memory<br/>sudo sh -c "echo "100m" >memory.limit_in_bytes"<br/>stress --vm-bytes 200m --vm-keep -m 1<br/>top |

### 限制内存top结果

隐藏一些结果、可以看到 200M和100M的内存占用率

| PID   | USER    | %CPU | %MEM                        | CMD    |
| ----- | ------- | ---- | --------------------------- | ------ |
| 32152 | Lucifer | 30%  | <font color=Red>5%</font>   | stress |
| 35174 | Lucifer | 32%  | <font color=Red>2.5%</font> | stress |

