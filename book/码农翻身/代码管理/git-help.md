## Git help 中文翻译

```
使用格式: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

以下是在各种情况下使用的常见Git命令:

开始一个工作区域(参见:git help tutorial命令)
   clone     克隆一个仓库到一个新目录中
   init      在当前目录创建一个空仓库或者重新初始化仓库

处理当前的更改(请参阅:git help everyday命令)
   add       暂存文件变更、或者说将变更的文件放进小推车
   mv        Move or rename a file, a directory, or a symlink
   restore   放弃文件区块更改
   rm        Remove files from the working tree and from the index


检查历史记录和状态(请参阅:git help revisions)
   bisect    Use binary search to find the commit that introduced a bug
   diff      Show changes between commits, commit and working tree, etc
   grep      Print lines matching a pattern
   log       显示提交的日志、历史
   show      显示各种类型的对象
   status    显示工作区(树)状态，显示文件修改、暂存、状态

分支
成长，标记和调整你们的共同编码维护历史

   branch    列出、创建或删除分支
   commit    将变更记录到仓库中，或者将小推车卸货到仓库
   merge     将两个或更多的分支合并(开发历史连接)在一起
   rebase    在另一个基本提示之上重新应用提交
   reset     将当前分支指向到指定的提交版本、或者重置文件暂存状态
   switch    切换分支  补充 checkout 切换分支
   tag       创建、列出、删除或验证使用GPG签名的标记对象
   补充 推送分支 git push origin --tags

合作 (请参阅 git help workflows命令)
   fetch     从另一个仓库中下载对象和refs
   pull      拉取并且合并到当前分支 通过远程仓库或者其他分支
   push      更新远程 refs 以及相关的对象，将本地仓库同步到远程仓库

'git help -a' 和 'git help -g'命令 列出可用的子命令和一些概念指南.
'git help <command>' 或者 'git help <concept>'查看具体的子命令或者概念指南.
'git help git'命令可查看系统描述
```

## Git help 英文帮助

```
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone     Clone a repository into a new directory
   init      Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add       Add file contents to the index
   mv        Move or rename a file, a directory, or a symlink
   restore   Restore working tree files
   rm        Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect    Use binary search to find the commit that introduced a bug
   diff      Show changes between commits, commit and working tree, etc
   grep      Print lines matching a pattern
   log       Show commit logs
   show      Show various types of objects
   status    Show the working tree status

grow, mark and tweak your common history
   branch    List, create, or delete branches
   commit    Record changes to the repository
   merge     Join two or more development histories together
   rebase    Reapply commits on top of another base tip
   reset     Reset current HEAD to the specified state
   switch    Switch branches
   tag       Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch     Download objects and refs from another repository
   pull      Fetch from and integrate with another repository or a local branch
   push      Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
See 'git help git' for an overview of the system.
```