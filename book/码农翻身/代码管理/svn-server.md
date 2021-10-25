Svn server 详细手册

## 检查低版本svn

```
rpm -qa | grep subversion  # 检查
yum remove subversion      # 卸载
```

## 安装svn

```
yum remove subversion
```

## 检查是否安装成功

- 查看版本

```
svnserve --version
```

- 返回信息

```
[root@VM_0_12_centos ~]# svnserve --versionsvnserve，版本 1.7.14 (r1542130)编译于 Apr 11 2018，02:40:28
版权所有 (C) 2013 Apache 软件基金会。此软件包含了许多人的贡献，请查看文件 NOTICE 以获得更多信息。Subversion 是开放源代码软件，请参阅 http://subversion.apache.org/ 站点。
下列版本库后端(FS) 模块可用:
fs_base : 模块只能操作BDB版本库。
fs_fs : 模块与文本文件(FSFS)版本库一起工作。
Cyrus SASL 认证可用。
```

## 创建代码库

- 创建目录与文件

```
# -p 和-R作用一致  递归创建
mkdir -p /opt/svn/mid                 # 创建中台仓库目录
mkdir -p /opt/svn/mid                 # 创建机器人仓库目录

svnadmin create /opt/svn/mid          # 初始化中台仓库文件
svnadmin create /opt/svn/robot        # 初始化机器人仓库文件
```

- 目录与文件结构

```
.
├── conf                               // 配置文件
│   ├── authz                             // 权限配置
│   ├── passwd                            // 账号密码配置
│   └── svnserve.conf                     // 服务配置 依赖的权限和密码文件
├── db                                 // 数据信息
│   ├── current
│   ├── format
│   ├── fsfs.conf
│   ├── fs-type
│   ├── min-unpacked-rev
│   ├── rep-cache.db                      // 具体仓库信息
│   ├── revprops
│   │   └── 0
│   │       ├── 0                        // 版本信息
│   │       └── 1
│   ├── revs
│   │   └── 0                                                                // 版本信息
│   │       ├── 0
│   │       └── 1
│   ├── transactions
│   ├── txn-current
│   ├── txn-current-lock
│   ├── txn-protorevs
│   ├── uuid
│   └── write-lock
├── format
├── hooks
│   ├── post-commit.tmpl
│   ├── post-lock.tmpl
│   ├── post-revprop-change.tmpl
│   ├── post-unlock.tmpl
│   ├── pre-commit.tmpl
│   ├── pre-lock.tmpl
│   ├── pre-revprop-change.tmpl
│   ├── pre-unlock.tmpl
│   └── start-commit.tmpl
├── locks
│   ├── db.lock
│   └── db-logs.lock
└── README.txt
```

## 配置代码库

- 编辑密码文件 /opt/svn/仓库目录/conf/passwd

```
[users]
username = passwod       # 可用的账号和密码
# username = password    # 注释掉的账号密码
```

- 编辑权限文件

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
svnserve -d -r /opt/svn/mid # 只启动mid仓库 svn checkout svn://域名:3690即可拉取
svnserve -d -r /opt/svn/ # 启动mid和robot svn checkout svn://域名:3690/mid拉取

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