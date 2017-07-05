package main

// doc
// http://blog.csdn.net/su_sai/article/details/51176753
// http 状态码
// http://blog.csdn.net/liangguangchuan/article/details/54575001
//
// http://studygolang.com/articles/2680

// go version go1.8.3 linux/amd64

// redis
// elasticsearch
// ssdb
// rabbitmq


import (
    "fmt"
    "flag"
    "net/http"
    "../DbSet"
)

// 设置全局配置变量，并带默认值
var (
    globalHttpHost = flag.String("globalHttpHost", "127.0.0.1:8080", "http服务监听主机端口")
    globalRedisHost = flag.String("globalRedisHost", "127.0.0.1:6379", "redis服务监听主机端口")

)


type Controller struct {
    redis *DbSet.Redis
}



func main() {
    redis := DbSet.NewRedisPool(*globalRedisHost, 0)
    ctrl := &Controller{redis}

    // 注册控制器函数
    http.HandleFunc("/get", ctrl.get_handler)
    http.HandleFunc("/post", ctrl.post_handler)

    err := http.ListenAndServe(*globalHttpHost, nil)
    if err != nil {
        fmt.Println("err")
    }
}



// curl http://127.0.0.1:8080/get?key=val1
// curl http://127.0.0.1:8080/get?key=val123
// get请求
func (this *Controller) get_handler(w http.ResponseWriter, req *http.Request) {
    defer req.Body.Close()

    query := req.URL.Query()

    val := query["key"][0]
    fmt.Println(val)


    this.redis.Set("key1122", "val1XXXXX")
    val1, err := this.redis.Get("key1122")
    if err == nil {
        fmt.Println(val1)
    }

    // fmt.Println(val1)



    fmt.Println("ok")
    // w.Write([]byte("get_handler"))
    w.Write([]byte(val))

}

// curl -d "key1=val111&userId=1034285" "127.0.0.1:8080/post"
// post 请求
func (this *Controller) post_handler(w http.ResponseWriter, req *http.Request) {
    defer req.Body.Close()

    post_val1 := req.PostFormValue("key1")
    fmt.Println(post_val1)

    fmt.Println("ok")
    w.Write([]byte("post_handler"))
}



