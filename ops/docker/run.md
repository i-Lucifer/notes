注：这里可能涉及到的是特征研究，而不是教学文章，虽然是第一篇文章，比如用到docker start命令，还没有讲解。

## 运行容器

- 运行一个应用程序
```bash
docker run --name centos centos:latest /bin/echo "Hello world"
# Output
# Hello world
```
- 参数解释说明

  | 参数                    | 解释                                |
  | ----------------------- | ----------------------------------- |
  | docker                  | 二进制可执行程序                    |
  | run                     | 和docker命令组合运行一个容器        |
  | --name centos           | 指定容器的运行名                    |
  | centos:latest           | 指定要使用的镜像，你可以理解为image |
  | /bin/echo "Hello world" | 在容器内要执行的命令                |

- 容器说明
    - 一个容器为一个进程而生，进程声明周期结束，容器也会停止
    
    - 上面的程序的进程可以理解为```/bin/echo "Hello world"```
    
    - 运行以下两条命令，可以看到持续输出Hello world
    
      ```bash
      docker start centos
      docker logs centos
      ```

## 运行交互式容器

- 运行一个容器

```bash
docker run -ti --name centos centos:latest /bin/bash
```

- 参数解释说明

  | 参数      | 解释                                    |
  | --------- | --------------------------------------- |
  | /bin/bash | 与上面对比，这个容器执行了一个shell脚本 |
  | -i        | stdin 与容器内的标准输入进行交互        |
  | -t        | term 容器内(伪)终端                     |
  | -d        | demon 后台启动程序                      |

- 参数组合说明

  - 下面提到的exec，均指docker exec -ti 容器名 /bin/bash
  - /bin/bash也可以换成其他命令，这样就不会进入容器，比如yarn build
  
  | 组合   | 说明                                                         |
  | ------ | ------------------------------------------------------------ |
  | -ti    | 启动容器，进入终端交互，并且能够标准输入，关闭窗口或者exit，容器会stop |
  | -i     | 比上面少了终端，能交互，但是看起来怪怪的                     |
  | -t     | 进入了终端，但是不能交互，使用exec进入后，能够正常交互       |
  | -d     | docker run -d --name centos centos:latest /bin/bash 执行完容器就停止了，且无法启动，和/bin/echo "Hello world"一样，属于一次性任务</br>以下两种持续任务，-c表示后面的语句是一个整体</br>docker run -d --name centos centos:latest /bin/bash -c "while true; do echo hello world; sleep 1; done" </br>docker run -d --name centos centos:latest /bin/bash -c "tail -f /dev/null" |
  | -d组合 | -tid、-td、-id生成的容器均会后台守护运行，返回一个容器ID     |
  
  