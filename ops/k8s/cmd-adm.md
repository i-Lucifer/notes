[toc]

## 帮助命令

```
kubeadm -h
```

## 介绍

adm用来帮你引导一个集群

### 示例 启动节点集群

- 主节点

  ```bash
  kubeadm init --kubernetes-version=可选参数版本
  
  # 得到一串信息
  ```

- 多台子节点

  ```bash
  kubeadm join 上面得到的信息
  ```

## 可用命令

| 命令       | 说明                                               |
| ---------- | -------------------------------------------------- |
| alpha      | 实验命令 不稳定的命令                              |
| completion | 指定shell                                          |
| config     | 管理kubeadm的集群配置，配置存储在集群的ConfigMap中 |
| init       | 集群 初始化 会得到一串信息，可能是下面提到的token  |
| join       | 集群 握手                                          |
| reset      | 集群 重置状态                                      |
| token      | 管理引导token                                      |
| upgrade    | 版本 更新                                          |
| version    | 版本 查看                                          |
| help       | 帮助信息                                           |
| -h         | 帮助信息                                           |

## 子命令

### alpha

alpha内部测试相关命令

```
kubeadm help alpha
```

| 子命令      | 说明                             |
| ----------- | -------------------------------- |
| certs       | 证书相关命令                     |
| kubeconfig  | 配置文件相关工具                 |
| selfhosting | 创建自托管集群，或者让集群自托管 |

### config

- 集群有一个名字为kubeadm-config的ConfigMap
- 1.8版本会在集群初始化时自动创建
- 1.7以下需要手动执行 kubeadm config upload创建
- 必须要要创建ConfigMap，当执行kubeadm时需要。

| 子命令  | 说明                                                 |
| ------- | ---------------------------------------------------- |
| images  | 和容器镜像进行交互                                   |
| migrate | 迁移配置，从文件中读取旧配置，并输出为新版本配置格式 |
| print   | 打印配置                                             |

### init

- 初始化集群
- 会执行多个阶段
  - 预检查
  - cert 证书生成
    - ca sa
    - apiserver apiserver-kubelet-client
    - front-proxy-ca front-proxy-client
    - etcd-ca etcd-server etcd-peer etcd-healthcheck-client apiserver-etcd-client
  - kubeconfig 配置
    - admin kubelet controller-manager scheduler
  - kubelet-start 写入设置然后启动kubelet
  - control-start 生成pod清单
    - api-server controller-manager scheduler
  - etcd 本地etcd相关
  - upload-config 上传配置到ConfigMap
  - upload-cert 上传证书
  - mark-control-plane 标记node为master
  - bootstrap-token 生成token，子节点加入时使用
  - kubelet-finalize 完整 在TLS之后更新配置 启动客户端证书(格式转换?)
  - addon 安装插件 CoreDNS kube-proxy

- 子命令

| 子命令 | 说明                         |
| ------ | ---------------------------- |
| phase  | 使用子命令，可以执行单个阶段 |

- 参数(只列举个别)

| 参数               | 说明                     |
| ------------------ | ------------------------ |
| --pod-network-cidr | 网络说明 flannel网络相关 |



### join

加入一个集群时，需要建立双向信任(俗称握手)，分为两步

- discovery 发现 子节点信任master节点
- TLS Bootstrap 引导启动 主节点信任子节点

服务发现有两种方案，只能使用其中一种

- 使用共享token和IP地址
- 提供标准的Kubeconfig文件，可以是本地文件，也可以通过URL(HTTPS)下载

服务发现示例

```
kubeadm join --discovery-token abcdef.1234567890abcdef 1.2.3.4:6443
kubeadm join --discovery-file path/to/file.conf
```

省略一大段翻译

join会执行以下阶段：

- 预处理
- 准备机器 下载证书 证书 配置 清单
- 启动kubelet
- 加入
  - 加入为ectd的成员
  - 更新ConfigMap状态
  - 标记为子节点

可用子命令

phase 逐步执行以上阶段

### reset

移除init或者join对机器的修改，主要有以下阶段

- 重置预处理
- 移除node在集群中的对象
- 移除etcd成员
- 清理node节点

子命令

phase 逐步执行以上阶段

### token

管理引导token，主要有以下命令

- 增 create，generate(生成但是不创建)
- 删 delete
- 查 list

### upgrade

更新集群版本，主要有以下命令

- apply 更新到指定版本
- diff 对比差异
- node 对子节点进行更新
- plan 检查新版本，并检查是否可升级

### version与completion不做介绍

