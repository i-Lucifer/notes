### 版本库数据结构

svn可以提交文件和目录，git如果目录里没有文件，也不会提交目录。

### git目录结构

```bash
.
├── hooks
├── info
├── object
├── logs
│   └── refs
│       ├── heads
│       └── remotes
│           └── origin
└── refs
    ├── heads
    ├── remotes
    │   └── origin
    └── tags
```

### 存储树结构

- 文件

```bash
blog
├── main.go   # 文件存储为blob
├── handler   # 目录存储为tree
    ├── hello.go
    └── api.go
```

- git数据结构

```golang
// 进行一次提交
type Md5 struct{
  Patient Md5    // 上次提交
  Author  string // 作者
  Commit  string // 备注
  Tree []Tree    // 一次可以提交多个目录
  Blob []Blob    // 一次可以提交多个文件
}

// 目录
type Tree struct{
    Tree []Tree  // 目录下可以有目录
  	Blob []Blob  // 目录下可以有文件
}

// 对应一个文件
type Blob struct{
  fileName string     // 文件名
  fileContent *string // 文件内容 或变更
  ...  								// 文件权限等
}
```

### 相同数据只存储一次

- 如果两个文件，内容相同，只是文件名不同，在存储树里，内容只记录一次

### 重命名

- 重命名时，不记录文件内容，只记录文件名变更

### 散列冲突问题

- 散列冲突时，git无法提供正确数据
- 散列冲突非常罕见

### 子模块

- pull 代码的本质是pull .git
- pull 子模块的本质，是将子模块的.git放到主项目的.git目录

```go
type Repo struct{
  Name	  string  // 仓库名 子模块名
	Path	  string	// 仓库地址 子仓库在主仓库里的地址
	Url			string	// 仓库地址 子仓库远程地址
  CurMd5	string	// 仓库版本 子仓库版本
  SubRepo []Repo
}
```



