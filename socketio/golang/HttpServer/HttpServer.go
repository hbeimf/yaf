package main

// http://blog.csdn.net/su_sai/article/details/51176753

import (
    "fmt"
    // "io/ioutil"
    "net/http"
    // "encoding/json"
)


type Controller struct {

}


// curl http://127.0.0.1:8080/get?key=val1
// curl http://127.0.0.1:8080/get?key=val123
// get请求
func (this *Controller) get_handler(w http.ResponseWriter, req *http.Request) {
    defer req.Body.Close()

    query := req.URL.Query()

    val := query["key"][0]
    fmt.Println(val)


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


func main() {
    ctrl := &Controller{}

    http.HandleFunc("/get", ctrl.get_handler)
    http.HandleFunc("/post", ctrl.post_handler)

    err := http.ListenAndServe("127.0.0.1:8080", nil)
    if err != nil {
        fmt.Println("err")
    }
}







// func hand(w http.ResponseWriter, r *http.Request) {
//     defer r.Body.Close()

//     fmt.Println("ok")
//     w.Write([]byte("connect ok"))


//     // body, err := ioutil.ReadAll(r.Body)
//     // if err != nil {
//     //     fmt.Println("read err")
//     // }
//     // fmt.Println(body)
//     // tmp := person{}
//     // err = json.Unmarshal(body, &tmp)  //JSON还原

//     // if err != nil {
//     //     fmt.Println("unmarshal err")
//     // }
//     // fmt.Println(tmp)
// }
