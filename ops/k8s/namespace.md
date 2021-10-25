## 命名空间管理

```bash
kebectl create namespace blog
kebectl delete namespace blog   # 删除命名空间时，会删除里面的所有Pod
```



## 编排

- namespace.yml

```yaml
apiVersion: v1

kind: Namespace

metadata:
    name: blog
```

- 上线

```bash
kubectl apply -f namespace.yml
```

