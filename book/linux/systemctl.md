## 进程管理

### 启动

```bash
systemctl start xxx
```

### 开机启动
```bash
systemctl enable xxx
systemctl disable xxx
```
### 开机启动列表
```bash
systemctl list-unit-files |grep docker
```
