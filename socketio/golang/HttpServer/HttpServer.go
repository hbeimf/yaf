package main

// http://blog.csdn.net/su_sai/article/details/51176753

import (
    "fmt"
    "io/ioutil"
    "net/http"
    "encoding/json"
)


type person struct {
    NAME string
    AGE  int
}


func main() {
    http.HandleFunc("/test", hand)
    err := http.ListenAndServe("127.0.0.1:8080", nil)
    if err != nil {
        fmt.Println("err")
    }
}


func hand(w http.ResponseWriter, r *http.Request) {
    fmt.Println("ok")
    w.Write([]byte("connect ok"))

    defer r.Body.Close()
    body, err := ioutil.ReadAll(r.Body)
    if err != nil {
        fmt.Println("read err")
    }
    fmt.Println(body)
    tmp := person{}
    err = json.Unmarshal(body, &tmp)  //JSON还原

    if err != nil {
        fmt.Println("unmarshal err")
    }
    fmt.Println(tmp)
}
