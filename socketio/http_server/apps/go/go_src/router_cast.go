package main

import (
    "github.com/goerlang/etf"
    "github.com/goerlang/node"
)

type ControllerCast interface {
    Excute(from etf.Pid, n *node.Node, message etf.Tuple)
}

var castRouters map[string]interface{}


func setCastRouter() {
    setCastList()
    setCastDefaultRouter()
}

func setCastList() {
    var ctrl listControllerCast
    addCast("list", &ctrl)
}


func setCastDefaultRouter() {
    var ctrl_default defaultControllerCast
    addCast("default", &ctrl_default)
}

func addCast(key string, controller ControllerCast) {
    castRouters[key] = controller
}

func getCast(key string) (ctrl ControllerCast) {
    if _, ok := castRouters[key]; ok {
        return castRouters[key].(ControllerCast)
    }
    return castRouters["default"].(ControllerCast)
}


