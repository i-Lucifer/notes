[[TOC]]

## Cgroups介绍

### 简单描述

- Cgroups(Control Groups)是Linux内核提供的机制
- 待补充

### 基本功能归纳

- 资源限制 比如分配内存上线，一旦超出触发OOM
- 优先级分配 通过分配CPU时间片数量和磁盘IO带宽，实际上等同于控制了任务优先级
- 资源监控与资源统计 统计cpu使用时长，内存用量等，适合云端产品按量计费
- 任务控制 对任务挂起、恢复等

### 管理的资源

生效范围：一组进程以及子进程

资源范围：CPU、内存、存储、网络等

### cgourps三个组件
- cgroup
- subsystem
- hierarchy

## Docker如何使用Cgroups

- Docker可以通过Cgroups实现容器限制和监控资源

- 启动容器
  - -m参数可以限制内存
  - docker会为每个容器，在系统的hierarchy中创建cgroup

```bash
# 运行容器  128MB=134,217,728B
docker run -tid -m 128m --name centos centos
# 得到容器ID
fb278bfd9f087293d93b6698e8aa1b97b2fce297504dfe38ed8e57d0df47d8fd
```

- 查看相关信息(Mac)

```bash
docker inspect centos
# 找到内存的一项为 "Memory": 134217728,
```

- 查看内存(书中提到Linux)

```bash
cd /sys/fs/cgroup/memory/docker/容器ID

cat memory.limit_in_bytes  # 查看内存限制  134217728
cat memory.usage_in_bytes  # 查看使用内存  6295552
```

## 使用Go实现通过Cgroup限制容器资源

- 挖坑 待填
