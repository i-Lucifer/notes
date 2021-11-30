[TOC]

## [svn文字教程 外连](https://easydoc.top/s/78711005/uSJD1CDg/33195524)

## svn常用命令

| 简写           | 命令                     | 说明                   |
| -------------- | ------------------------ | ---------------------- |
| svn co 地址    | svn *checkout 地址*      | 克隆仓库               |
| svn up         | svn update               | 更新代码               |
|                | svn commit -m "提交描述" | 提交代码               |
|                | svn add 文件名           | *添加指定文件到版本库* |
|                | svn status               | 查看状态               |
|                | svn log 文件名           | 查看指定文件所有历史   |
|                | svn cleanup              | 清理                   |
| svn del 文件名 | svn delete 文件名        | 从仓库删除文件         |

## 忽略子文件保留母文件夹

```
svn make dir
svn propset svn:ignore '*' dir
svn ci -m '描述'
```

## 忽略子文件和母文件夹

```
svn make dir
svn propset svn:ignore 'dir' .
svn ci -m '描述'
```