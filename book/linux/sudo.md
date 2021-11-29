## su和sudo的区别

| 区别项   | su       | sudo         |
| -------- | -------- | ------------ |
| 提供密码 | root密码 | 当前用户密码 |

## 免sudo

- 创建用户组

  ```
  groupadd docker
  ```

- 加入用户组

  ```
  usermod -aG docker $USER
  ```

- 重新登录并验证