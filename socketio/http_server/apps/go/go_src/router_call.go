package main

import (
    "github.com/goerlang/etf"
)

type ControllerCall interface {
    Excute(message etf.Tuple) (*etf.Term)
}

var callRouters map[string]interface{}

func setCallRouter() {
    addRouterCall("demo", &DemoController{})
    addRouterCall("list", &ListController{})
    addRouterCall("curl", &CurlController{})
    addRouterCall("iconv", &IconvController{})

    // erlang 调用示例:
    // gen_server:call(GoMBox, {str, str_replace, StrRes, FindStr, ReplaceTo}).
    addRouterCall("str", &StrController{})

    addRouterCall("default", &DefaultController{})
}

// ------------------------------------------------
func addRouterCall(key string, controller ControllerCall) {
    callRouters[key] = controller
}

func getCall(key string) (ctrl ControllerCall) {
    if _, ok := callRouters[key]; ok {
        return callRouters[key].(ControllerCall)
    }
    return callRouters["default"].(ControllerCall)
}


