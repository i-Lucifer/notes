## 节点管理

- **集群登入**

> redis-cli -c  #集群后 不加-c 无法进行集群操作

- **查看节点信息**

> redis-cli --cluster check 127.0.0.1:6379

- **节点删除**

  - 删除主节点要先转移hash槽对应数据
    - 要转移多少个哈希槽
    - 转移目标的节点ID
    - 转移的节点id (可选all,从所有节点转移)  
    - ```redis-cli --cluster reshard [转移的ip:port]   ```
  - 删除
    - 要删除的节点id
    - 删除主节点后，对应的从节点自动匹配新的主节点
    - ```redis-cli --cluster del-node [连接节点ip:port]```  

- **主从转换，故障转移**

  - 登入从节点

    ```redis-cli -h [从节点ip] -p [6379]```

  - 转移

    ```cluster failover```

- **添加节点**

  - 添加主节点

    - 新节点不能包含数据和旧集群配置文件nodes-6379.conf
    - ```redis-cli --cluster add-node [新节点ip:port]  [集群任意节点ip:port]```  

  - 转移hash槽

    - 要转移多少个哈希槽 
    - 转移目标的节点ID
    - 转移的节点id(可选all,从所有节点转移
    - ```redis-cli --cluster reshard  [要转移的节点ip:port]```   

  - 平衡hash槽

    ```redis-cli --cluster rebalance --cluster -threshold 1 [新节点ip:port]```

  - 添加从节点

    - 新节点不能包含数据和旧集群配置文件 nodes-6379.conf
    - ```redis-cli --cluster add-node [新节点ip:port] [集群任意节点ip:port] --cluster-slave  --cluster-master-id [主节点id]```      



## 集群命令表

| 类别          | 命令                                      | 说明                          | 备注   |
| ------------- | ----------------------------------------- | ----------------------------- | ------ |
| 集群(cluster) | cluster info                              | 打印集群的信息                | 已实践 |
| 集群(cluster) | cluster nodes                             | 列出集群所有节点和详细信息    | 已实践 |
| 节点(node)    | cluster meet <ip> <port>                  | 添加节点                      | 已实践 |
|               | cluster forget <node_id>                  | 移除节点                      | 已理解 |
|               | cluster replicate <node_id>               | 设置为从节点                  | 已理解 |
|               | cluster saveconfig                        | 将节点配置文件写入硬盘        | 已理解 |
|               | cluster slaves <node_id>                  | 查看从节点的主节点            | 已理解 |
|               | cluster set-config-epoch                  | 强制设置configEpoch           | 不理解 |
| 槽(slot)      | cluster addslots <slots>                  | 节点 添加槽                   | 已实践 |
|               | cluster delslots <slots>                  | 节点 移除槽                   | 已理解 |
|               | cluster flushslots                        | 节点 清空槽                   | 已理解 |
|               | cluster setslot <slot> node <nodeid>      | 强制 添加槽 先删除后添加      |        |
|               | cluster setslot <slot> migrating <nodeid> | 迁移槽                        |        |
|               | cluster setslot <slot> importing <nodeis> | 导入槽                        |        |
|               | cluster setslot <slot> stable             | 取消槽的导入或者迁移          |        |
| 键(key)       | cluster keyslot <key>                     | 计算键key应该被放置在哪个槽上 | 已理解 |
|               | cluster countkeysinslot <slot>            | 统计槽内key的数量             | 已理解 |
|               | cluster getkeysinslot <slot> <num>        | 返回槽中指定数量的key         | 已理解 |
| 其它          | cluster myid                              | 返回节点的ID                  | 已理解 |
|               | cluster slots                             | 返回节点负责的slot            | 已理解 |
|               | cluster reset                             | 重置集群 警告 慎用            | 已理解 |

## 其他

- 批量添加槽

  > 方式一 命令
  >
  > redis-cli cluster addslots {开始数字..结束数字}
  >
  > 方式二 lua脚本
  >
  > eval "for i=开始数字,结束数字,1 do redis.call('cluster','addslots',i) end" 0



