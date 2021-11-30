[toc]

## yum包管理

### 增删改查

```
yum install
yum remove
yum update
yum search
yum list
```

### 缓存 增删

```bash
# 增
yum makecahce
# 删
# 所有
yum clean
yum clean all
# 清除索引和旧索引
yum clean headers
yum clean oldheaders
# 清缓存包
yum clean packages
```

### 源 增查

```bash
# 增
yum-config-manager --add-repo http://mirrors.aliyun.com/repo/Centos-7.repo
# 查
rpm -qa | grep yum
```

### 删除yum

```bash
rpm -qa | grep yum | xargs rpm -e --nodeps
```





