[TOC]

## 命令分类

- redis-cli 进入交互终端命令   后面称内部命令
- redis-cli 不进入交互终端命令 后面称外部命令

## redis外部命令

### 帮助命令

```
redis-cli --cluster help
```

>Cluster Manager Commands: 集群管理命令
>  create         host1:port1 ... hostN:portN
>                 --cluster-replicas <arg>
>  check          host:port
>                 --cluster-search-multiple-owners
>  info           host:port
>  fix            host:port
>                 --cluster-search-multiple-owners
>                 --cluster-fix-with-unreachable-masters
>  reshard        host:port
>                 --cluster-from <arg>
>                 --cluster-to <arg>
>                 --cluster-slots <arg>
>                 --cluster-yes
>                 --cluster-timeout <arg>
>                 --cluster-pipeline <arg>
>                 --cluster-replace
>  rebalance      host:port
>                 --cluster-weight <node1=w1...nodeN=wN>
>                 --cluster-use-empty-masters
>                 --cluster-timeout <arg>
>                 --cluster-simulate
>                 --cluster-pipeline <arg>
>                 --cluster-threshold <arg>
>                 --cluster-replace
>  add-node       new_host:new_port existing_host:existing_port
>                 --cluster-slave
>                 --cluster-master-id <arg>
>  del-node       host:port node_id
>  call           host:port command arg arg .. arg
>                 --cluster-only-masters
>                 --cluster-only-replicas
>  set-timeout    host:port milliseconds
>  import         host:port
>                 --cluster-from <arg>
>                 --cluster-copy
>                 --cluster-replace
>  backup         host:port backup_directory 备份目录
>  help        帮助
>
>For check, fix, reshard, del-node, set-timeout you can specify the host and port of any working node in the cluster.
>
>对于check, fix, reshard, del-node, set-timeout，您可以指定集群中任何工作节点的主机和端口。

### 创建集群

- 不开启主从，至少三个节点

  ```
  redis-cli --cluster create \
  127.0.0.1:6379 127.0.0.1:6378 127.0.0.1:6377
  ```

- 开启1主1从，至少六个节点

  ```
  redis-cli --cluster create \
  127.0.0.1:6379 127.0.0.1:6378 127.0.0.1:6377 \
  127.0.0.1:16379 127.0.0.1:16378 127.0.0.1:16377 \
  --cluster-replicas 1
  ```

  