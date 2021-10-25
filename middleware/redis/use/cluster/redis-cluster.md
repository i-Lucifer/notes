---
title: 'redis-集群'
date: 2020-08-18 21:18:17
tags: []
published: true
hideInList: false
feature: 
isTop: false
---
## 概念

- 每次操作根据key进行hash运算，生成一个[0-16384]的hash值 （生成的hash值/16383取余数），最后找到对应hash值的节点
- 每次重启集群后，节点关系改变
- 删除主节点后，对应的从节点自动匹配新的主节点
- 每一台集群的密码都需要相同

## 配置列表

| 配置项                              | 说明                                                         |
| ----------------------------------- | ------------------------------------------------------------ |
| cluster-enabled yes                 | 集群开关                                                     |
| cluster-config-file nodes-6379.conf | **集群节点名** 系统自动维护的集群配置文件                    |
| cluster-node-timeout 15000          | 节点心跳超时时间，超过这个时间认为节点故障                   |
| cluster-replica-validity-factor 10  | **子节点是否过载，是否能成为主节点的可能性** timeout*factor后 从节点启动故障迁移 |
| cluster-migration-barrier 1         | **从节点个数** 最小从节点数为1，至少有一个从节点，故障时才会启动迁移 |
| cluster-require-full-coverage yes   | 部分节点宕机，是否停止工作 no时其他节点仍然可读              |
| cluster-replica-no-failover no      | 子节点不允许成为主节点                                       |

## 配置详解

- cluster-enabled yes
      如果配置yes则开启集群功能，此redis实例作为集群的一个节点，否则，它是一个普通的单一的redis实例。
- cluster-config-file nodes-6379.conf
      虽然此配置的名字叫"集群配置文件"，但是此配置文件不能人工编辑，它是集群节点自动维护的文件，主要用于记录集群中有哪些节点、他们的状态以及一些持久化参数等，方便在重启时恢复这些状态。通常是在收到请求之后这个文件就会被更新。
- cluster-node-timeout 15000
      这是集群中的节点能够失联的最大时间，超过这个时间，该节点就会被认为故障。如果主节点超过这个时间还是不可达，则用它的从节点将启动故障迁移，升级成主节点。注意，任何一个节点在这个时间之内如果还是没有连上大部分的主节点，则此节点将停止接收任何请求。一般设置为15秒即可。
- cluster-slave-validity-factor 10
      如果设置成０，则无论从节点与主节点失联多久，从节点都会尝试升级成主节点。如果设置成正数，则cluster-node-timeout乘以cluster-slave-validity-factor得到的时间，是从节点与主节点失联后，此从节点数据有效的最长时间，超过这个时间，从节点不会启动故障迁移。假设cluster-node-timeout=5，cluster-slave-validity-factor=10，则如果从节点跟主节点失联超过50秒，此从节点不能成为主节点。注意，如果此参数配置为非0，将可能出现由于某主节点失联却没有从节点能顶上的情况，从而导致集群不能正常工作，在这种情况下，只有等到原来的主节点重新回归到集群，集群才恢复运作。
- cluster-migration-barrier 1
      主节点需要的最小从节点数，只有达到这个数，主节点失败时，它从节点才会进行迁移。更详细介绍可以看本教程后面关于副本迁移到部分。
- cluster-require-full-coverage yes
      在部分key所在的节点不可用时，如果此参数设置为"yes"(默认值), 则整个集群停止接受操作；如果此参数设置为”no”，则集群依然为可达节点上的key提供读操作。

## 集群运行

- 注意项
  - 至少需要6个节点才能创建集群
  - 每个节点数据必须是空
  - 每个节点提供集群端口号 16379  ，注意防火墙
- 运行所有节点
  - 所有节点配置完并运行后，检查 ps -ef |grep redis  是否有[cluster] 标识
- 开启集群
  - redis-cli --cluster create [ ]  [ ]  [ ]  [ ]  [ ]  [ ]  --cluster-replicas 1
  - 1代表1个主节点对应几个子节点，创建集群至少需要3个主节点
  - 哈希槽分配： 16383个哈希槽  /主节点个数 
- 节点配置文件
  - nodes-6379.conf    # redis根目录，存放节点关系结构，系统自动维护，不可人工修改
