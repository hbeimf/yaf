package DbSet

import (
    "testing"
    // "fmt"
)

var obj = NewRedisPool("127.0.0.1:6379", 0)

func TestGet(t *testing.T) {
    val, err := obj.Get("key1122")
    t.Log("getXXX", val, err)
}

func TestSetGet(t *testing.T) {
    obj.Set("key100", "value_100")

    val, err := obj.Get("key100")
    t.Log("设置", val, err)
}


func TestLPush(t *testing.T) {
    listName := "list100"
    obj.LPush(listName, "value222")
    res, err := obj.RPop(listName)
    t.Log("队列左进右出", res, err)
}



func TestSetNX(t *testing.T) {
    obj.SetNX("key1000", "value_1000")

    obj.EXPIRE("key1000", 30)
}



