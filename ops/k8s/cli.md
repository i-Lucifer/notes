## 基本命令

### 帮助

```
kubectl -h
```

### 资源分类

| -          | 增   | 删     | 改   | 查   |
| ---------- | ---- | ------ | ---- | ---- |
| node       |      | delete |      | get  |
| pod        |      |        |      |      |
| services   |      |        |      |      |
| deployment |      |        |      |      |
| namespace  |      | delete |      |      |




### 增删改查

#### 增

#### 删

```
kubectl delete pod <pod-name>
```

#### 改

#### 查

#####  查 get

```bash
kubectl get pods   # 查pod
kubectl get nodes  # 查节点
kubectl get services # 查服务
kubectl get deployments # 查部署

kubectl get replicasets # 查副本

# 以下三个资源提示没有资源类型 
kubectl get event      # 查事件
kubectl get namesapces # 查命名空间
kubectl get replicationcontrollers
```

- pod

```
NAME                             READY   STATUS    RESTARTS   AGE
mysql-67964dcb74-q5qfz           1/1     Running   0          111d
redis-deploy-579f9dc958-6rr2h    1/1     Running   0          111d
redis-deploy-579f9dc958-zxfwg    1/1     Running   0          111d
skywalking-oap-68694674c-bbttr   1/1     Running   0          111d
```

- 查节点

```
NAME     STATUS   ROLES    AGE    VERSION
master   Ready    master   126d   v1.19.5
node1    Ready    <none>   126d   v1.19.5
```

- 查服务

```
NAME             TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                           AGE
kubernetes       ClusterIP      10.96.0.1      <none>        443/TCP                           126d
mysql            LoadBalancer   10.96.164.57   <pending>     3306:30858/TCP                    111d
redis-port       NodePort       10.96.181.46   <none>        6379:30379/TCP                    123d
skywalking-oap   LoadBalancer   10.96.66.36    <pending>     11800:31601/TCP,12800:30570/TCP   111d
```

- 查部署

```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
mysql            1/1     1            1           111d
redis-deploy     2/2     2            2           123d
skywalking-oap   1/1     1            1           111d
```

查副本

```
NAME                       DESIRED   CURRENT   READY   AGE
mysql-67964dcb74           1         1         1       111d
redis-deploy-579f9dc958    2         2         2       111d
redis-deploy-587df48c5f    0         0         0       123d
skywalking-oap-68694674c   1         1         1       111d
```

##### 查 desc

```bash
kubectl describe pod pod-name
kubectl describe node node-name
kubectl describe deployment deployment-name
```

