## 安装svn

```
yum remove subversion
```

## 检查是否安装成功

- 查看版本

```
svnserve --version
```

## 创建代码库

- 创建目录与文件

```
# -p 和-R作用一致  递归创建
mkdir -p /opt/svn/mid                 # 创建中台仓库目录

# 不创建目录可以直接初始化
svnadmin create /opt/svn/mid          # 初始化中台仓库文件
svnadmin create /opt/svn/robot        # 初始化机器人仓库文件
svnadmin create /opt/svn/games        # 初始化游戏组项目
```

## 配置代码库

- 编辑密码文件 /opt/svn/仓库目录/conf/passwd

```
[users]
username = passwod       # 可用的账号和密码
# username = password    # 注释掉的账号密码
```

- 编辑权限文件 auth

```
[aliases]   # 别名配置 让运维去研究吧

[groups]    # 组配置 让运维去研究吧    

[/]             # 权限目录 可以对目录 子目录设置权限
username = rw   # r读权限 w写权限 * 代表所有
```

- 编辑svn服务配置文件

```
[general]             # 一般配置
anon-access = none    # 匿名访问 不允许  
auth-access = write   # 密码访问 可写

password-db = passwd  # 导入密码配置文件

authz-db = authz      # 导入权限配置我呢间

realm = mid(项目目录)  # 命名空间配置，可以与项目目录一致，也可以随意     

[sasl]                # 其他配置
```

## 停止与启动

- 参数-d，守护进程
- 参数-r，启动的目录

```
svnserve -d -r /opt/svn/ # svn checkout svn://域名:3690/仓库目录

killall svnserve    # 杀死进程
```

## 查看进程与端口

- 查看进程

```
netstat -ln |grep 3690    # 服务器查看进程
```

- 查看端口

```
telnet 域名 3690           # 客户端查看端口
```