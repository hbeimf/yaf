package main

// http://blog.csdn.net/su_sai/article/details/51176753

import (
    "fmt"
    // "io/ioutil"
    "net/http"
    // "encoding/json"
)


// type person struct {
//     NAME string
//     AGE  int
// }


func main() {
    http.HandleFunc("/test", hand)
    http.HandleFunc("/get", get_handler)
    http.HandleFunc("/post", post_handler)

    err := http.ListenAndServe("127.0.0.1:8080", nil)
    if err != nil {
        fmt.Println("err")
    }
}

// curl 127.0.0.1:8080/test
func get_handler(w http.ResponseWriter, r *http.Request) {
    defer r.Body.Close()

    fmt.Println("ok")
    w.Write([]byte("connect ok"))
}

// curl 127.0.0.1:8080/test
func post_handler(w http.ResponseWriter, r *http.Request) {
    defer r.Body.Close()

    fmt.Println("ok")
    w.Write([]byte("connect ok"))
}





func hand(w http.ResponseWriter, r *http.Request) {
    defer r.Body.Close()

    fmt.Println("ok")
    w.Write([]byte("connect ok"))


    // body, err := ioutil.ReadAll(r.Body)
    // if err != nil {
    //     fmt.Println("read err")
    // }
    // fmt.Println(body)
    // tmp := person{}
    // err = json.Unmarshal(body, &tmp)  //JSON还原

    // if err != nil {
    //     fmt.Println("unmarshal err")
    // }
    // fmt.Println(tmp)
}
