[TOC]
[[TOC]]

## 常用命令
| 分类       | 作用        | git命令                        | svn命令                | 其他说明                                |
| ---------- | ----------- | ------------------------------ | ---------------------- | --------------------------------------- |
| 初始化     | 初始化      | init                           | 服务器初始化           |                                         |
|            | 克隆        | clone                          | checkout               |                                         |
| 暂存提交   | 增          | add                            | 同                     |                                         |
|            | 增          | commit                         | 同                     |                                         |
|            | 删          | rm                             | delete                 |                                         |
|            | 改          | reset                          |                        |                                         |
|            |             |                                |                        |                                         |
| 历史与状态 | 查 状态     | status                         | 同                     |                                         |
|            | 查 历史     | log                            | 同                     |                                         |
|            | 查 对比差异 | diff                           |                        |                                         |
|            | 查 查看代码 | show                           |                        |                                         |
| 分支管理   | 增          | branch 新分支名                | copy -m "备注" /create |                                         |
|            | 删          | branch -d 分支名               |                        |                                         |
|            | 改 切换     | checkout或switch               |                        |                                         |
|            | 暂存状态    | <font color="red">state</font> |                        | checkout冲突时用                        |
|            | 改 合并     | merge 待合并分支               |                        | 两条线 有交织                           |
|            | 改 合并     | rebase 待合并分支              |                        | 一条线 无交织                           |
|            | 查          | branch -a                      |                        | -a 时包含远程                           |
| 团队协作   | 推送        | push                           |                        |                                         |
|            | 更新        | fetch                          |                        | 只拉代码，不合并，vscode有自动fetch功能 |
|            | 更新        | pull                           |                        | pull=fetch+merge                        |
|            | 关联仓库    | remote add origin `地址`       |                        | origin类似一个分支                      |

## 扩展命令

| 分类     | 作用                                                         | git命令                              | 其他说明                                                     |
| -------- | ------------------------------------------------------------ | ------------------------------------ | ------------------------------------------------------------ |
| 初始化   | 克隆                                                         | clone --depth                        | 克隆指定深度的 commit                                        |
|          |                                                              |                                      |                                                              |
| 团队协作 | 回滚                                                         | revert                               |                                                              |
|          |                                                              |                                      |                                                              |
| 标签管理 | 增                                                           | tag 版本                             |                                                              |
|          | 删                                                           | tag -d 版本                          |                                                              |
|          | 推                                                           | push origin --tags                   |                                                              |
|          |                                                              |                                      |                                                              |
| 排查     | 查找                                                         | grep 字符串                          | 不用切换分支，查到出现字符串的文件                           |
| 回归排查 | [二分法排错](http://www.ruanyifeng.com/blog/2018/12/git-bisect.html) | bisect start [最近的版本] [早期版本] | 进入二分法拍错，假定100次提交，会切换到50                    |
|          |                                                              |                                      |                                                              |
|          |                                                              | bisect good                          | 标记正常，自动切换到75                                       |
|          |                                                              | bisect bad                           | 标记异常，自动切换到62                                       |
|          |                                                              | bisect reset                         | 退出查错                                                     |
|          |                                                              |                                      |                                                              |
| 子模块   | 增                                                           | submodule add                        | 会产生 <font color=red>.gitmodules</font> <font color=blue>仓库文件夹</font> <font color=red>./git/module/仓库名</font> |
|          | 拉取                                                         | submodule int --recursive            |                                                              |
|          | 更新                                                         | update --recursive                   |                                                              |

## 常见问题

### git和svn的区别

- svn中心化
- git去中心化，每个节点的地位是平等的，拥有自己的版本库，无网络也方便本地版本维护

### rebase和merge区别

- 都是合并分支的命令

| 命令   | 区别                                               | 区别二                                              |
| ------ | -------------------------------------------------- | --------------------------------------------------- |
| merge  | 产生两条线，线上单路记录每次提交的节点             | 合并后，如果子分支删除，则主分支只记录了merge命令点 |
| rebase | 产生一条提交线，线上记录着所有提交接点，永远一条线 | 没有子分支，所有记录完整保留                        |

- 使用哪个好
  - 如果你想有个稳定的，健壮的代码记录版本，应该使用rebase
  - Rebase可以提供一套清晰的代码历史
  - rebase最大的好处，并不是消除merge，而是避免merge的交织
  - 使用rebase还是使用merge，更多的是管理风格的事情
- 现状
  - 只有极少数公司使用rebase

### pull和fetch的区别

- 区别

  - git fetch branch是把名字为branch的远程分支拉取到本地

  - git pull branch 是在fetch的基础上，把branch分支和当前分支合并
  - 因此pull = fetch+merge

- 扩展

  - pull有合并操作
  - 添加远程分支时git remote add origin xxx.git，关联远程分支
  - 这里的origin本质上算是一种别名

### 子模块 submodule

- 为什么要用子模块

- 常用命令

```bash
# 初始化
git submodule add
# 使用者
git clone 主项目
git submodule update --init --recursive   # 递归初始化
git submodule update --recursive					# 递归更新
git submodule update --remote							# 更新依赖 子项目
```

### 其他

#### 关联远程空仓库

```
git remote add origin xxx.git
git push -u origin master
```

