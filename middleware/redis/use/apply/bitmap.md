[TOC]

## 前提知识

- 数据结构与算法 字节与位



## 位置说明

- h 的ASCII码是104
- 对应二进制是1101000

| **二进制**  | **0** | **1** | **1** | **0** | **1** | **0** | **0** | **0** |
| ----------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| 8位         | 8     | 7     | 6     | 5     | 4     | 3     | 2     | 1     |
| Redis位图位 | 0     | 1     | 2     | 3     | 4     | 5     | 6     | 7     |

## 位图写 setbit

- 方式一 位图的本质是字符串

  ```bash
  set key string
  ```

- 方式二

  ```bash
  setbit key offset bool
  
  # 示例
  setbit name 1 1
  setbit name 2 1
  setbit name 4 1
  ```

## 位图读 getbit

- 方式一

  ```
  get name
  ```

- 方式二

  ```bash
  get key offset
  
  # 示例
  getbit name 0  # 如果存的是127个ASCII,偏移0必定为0
  getbit name 2
  getbit name 3
  getbit name 4
  getbit name 5
  getbit name 6
  getbit name 7
  ```

  ## 统计与查找 bitcount bitpos

  ## 批量操作 bitfield

  