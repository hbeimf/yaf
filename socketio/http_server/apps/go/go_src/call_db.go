package main

import (
    "github.com/goerlang/etf"
    // "github.com/tidwall/gjson"
    "log"
    // "github.com/tidwall/gjson"
    "./DbSet"
)

// ================================================================
type DbController struct  {
    // Controller
}


// var redis = DbSet.NewRedisPool("127.0.0.1:6379", 0)

func (this *DbController) Excute(message etf.Tuple) (*etf.Term) {
    log.Printf("message default: %#v", message)

    // 仅作测试用，如果上线， 要初始化成全局变量，
    redis := DbSet.NewRedisPool("127.0.0.1:6379", 0)

    redis.Set("key1122", "val1")
    val, err := redis.Get("key1")


    log.Printf("get: %#v %#v ", val, err)




    // log.Printf("message default: %#v", val)


    replyTerm := etf.Term(etf.Atom("db_do_nothing"))
    return &replyTerm
}




