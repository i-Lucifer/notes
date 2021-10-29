// 字典
typedef struct dict{
    dictType *type;
    void *privdata;
    dictht ht[2];
    int trehashidx;
}dict;

// 字典类型
typedef struct dictType{
    // 若干函数

}dictType;


// 字典哈希表
typedef struct dictht{
}dictht;


// 字典实体
typedef struct dictEntry{
}dictEntry;

