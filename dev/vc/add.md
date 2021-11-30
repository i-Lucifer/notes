## 快速复制新仓库
```bash
# 初始化
svnadmin create /opt/svn/games
# 复制配置
cp /opt/svn/mid/conf/passwd /opt/svn/games/conf/passwd
cp /opt/svn/mid/conf/authz /opt/svn/games/conf/authz
cp /opt/svn/mid/conf/svnserve.conf /opt/svn/games/conf/svnserve.conf 

# 命名空间
vim /opt/svn/games/conf/svnserve.conf 

# 重启
killall svnserve
svnserve -d -r /opt/svn/

# 客户端克隆
svn checkout svn://ali.io:3690/games
```

