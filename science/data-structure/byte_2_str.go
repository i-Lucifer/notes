package main

import (
	"fmt"
)

// 字符串的底层是字节数组
// 任何数据在内存中都是以字节存储
func main() {
	str := []byte{77, 81, 84, 84}
	fmt.Println(string(str)) // 输出MQTT
}
