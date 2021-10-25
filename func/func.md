[TOC]



# 助手函数



## 字符串处理

| 功能 | go                                                | java | php                                         |
| ---- | ------------------------------------------------- | ---- | ------------------------------------------- |
| 替换 | strings.Replace(string,old,new,-1)                |      | str_replace(new,old,string)                 |
| 切割 | strings.Split(string,<font color=red>flag</font>) |      | explode(<font color=red>flag</font>,string) |



## 格式转换

### toint

```go
int, err := strconv.Atoi(string)
int64, err := strconv.ParseInt(string, 10, 64)

int := int(int64)
```

### tostring

```go
string := strconv.Itoa(int)
string := strconv.FormatInt(int64,10)
```

###  float

```go
// 计算百分比
rate := strconv.FormatFloat(float64(int)*100/float64(uint+1), 'f', 3, 64)
```



## 时间处理

### 睡眠

| 功能       | go                                  | java | php  |
| ---------- | ----------------------------------- | ---- | ---- |
| 按小时睡眠 | time.Sleep(1 * time.Hour)           |      |      |
| 按分钟睡眠 | time.Sleep(1 * time.Minute)         |      |      |
| 按秒睡眠   | time.Sleep(1* time.Second)          |      |      |
| 按毫秒睡眠 | time.Sleep(1000 * time.Millisecond) |      |      |
| 按微秒睡眠 | time.Sleep(1000 * time.Microsecond) |      |      |
| 按纳秒睡眠 | time.Sleep(1000 * time.Nanosecond)  |      |      |

### 时间转换

| 功能        | go                                               | java | php  |
| ----------- | ------------------------------------------------ | ---- | ---- |
| today       | time.Now().Format("2006/01/02")                  |      |      |
| tomorrow    | time.Now().AddDate(0, 0, 1).Format("2006-01-02") |      |      |
| HourAppoint | HourAppoint                                      |      |      |

### 指定小时 HourAppoint

```go
func HourAppoint(hour int) (timestamp int64) {
	now := time.Now()
	timestamp = time.Date(now.Year(), now.Month(), now.Day(), hour, 0, 0, 0, now.Location()).Unix()
	return
}
```

### 今日起止时间

### 今日倒计时

```
func Countdown() (countdown int64) {
	now := time.Now()
	timestamp := time.Date(now.Year(), now.Month(), now.Day(), 24, 0, 0, 0, now.Location()).Unix()
	fmt.Println(timestamp)
	return (timestamp - now.Unix())
}
```



### 周起止时间



### 月起止时间



### 季度起止时间



### 年起止时间



## cookie && session

- 向浏览器写cookie

```go
cookie := http.Cookie{
  Name:     "_cookie",
  Value:    session.Uuid,
  HttpOnly: true,
}
http.SetCookie(w, &cookie)
```

## md5签名

- 标准签名

```php
/**
 * MD5签名
 * 自动添加时间戳
 */
function sign(&$param, $secret){
    $param['timestamp'] = time();
    ksort($param);
    $stringB = http_build_query($param) . "&key=$secret"; // 注意空格以及中文字符的编译
    $param['sign'] = strtoupper(md5($stringB));
}
```

- 兼容空格以及中文无法解析 慎用

```php
function sign(&$param, $secret){
    $param['timestamp'] = time();
    ksort($param);
    $stringA = "";
    foreach ($param as $key => $value) {
        $stringA .= $key . "=" . $value . "&";
    }
    $stringB = $stringA  . "key=$secret";
    $param['sign'] = strtoupper(md5($stringB));
}
```

