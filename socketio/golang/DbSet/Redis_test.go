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



