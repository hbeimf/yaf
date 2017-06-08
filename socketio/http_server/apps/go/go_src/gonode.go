package main

import (
    "bufio"
    "flag"
    "fmt"
    "github.com/goerlang/etf"
    "github.com/goerlang/node"
    "log"
    "os"
    "strconv"
    "runtime"
    "strings"
)

type srv struct {
    node.GenServerImpl
    completeChan chan bool
    serverName string
}

var SrvName string
var NodeName string
var LogFile string
var Cookie string
var err error
var EpmdPort int
var EnableRPC bool
var PidFile string

var enode *node.Node
var serverId int


// 根据命令行解析参数
func init() {
    flag.StringVar(&LogFile, "log", "", "log file. if not setted then output on console")
    flag.StringVar(&SrvName, "gen_server", "go_srv", "gonode gen_server name")
    flag.StringVar(&NodeName, "name", "gonode@localhost", "gonode node name")
    flag.StringVar(&Cookie, "cookie", "123", "cookie for gonode for interaction with erlang node")
    flag.IntVar(&EpmdPort, "epmd_port", 5588, "epmd port")
    flag.BoolVar(&EnableRPC, "rpc", false, "enable RPC")
    flag.StringVar(&PidFile, "pid_file", "", "pid file path")

    flag.IntVar(&serverId, "server_id", 10000, "新进程编号")

    callRouters = make(map[string]interface{})
    castRouters = make(map[string]interface{})
}

func main() {
    Start()
    return
}

func Start() {
    // 设置路由　
    setCallRouter()
    setCastRouter()

    startNode()
    startGenServer(SrvName)

}

func startNode() {
    // Parse CLI flags
    flag.Parse()

    setup_logging()
    write_pid()

    log.Println("node started")

    // Initialize new node with given name and cookie
    enode = node.NewNode(NodeName, Cookie)

    // Allow node be available on EpmdPort port
    err = enode.Publish(EpmdPort)
    if err != nil {
        log.Fatalf("Cannot publish: %s", err)
    }

    return
}


func startGenServer(serverName string) {
    // Create channel to receive message when main process should be stopped
    completeChan := make(chan bool)

    // Initialize new instance of srv structure which implements Process behaviour
    eSrv := new(srv)

    // Spawn process with one arguments
    enode.Spawn(eSrv, completeChan)

    // 给进程注册一个名称
    eSrv.Node.Register(etf.Atom(serverName), eSrv.Self)
    eSrv.serverName = serverName

    // RPC
    // if EnableRPC {
    //     // Create closure
    //     eClos := func(terms etf.List) (r etf.Term) {
    //         r = etf.Term(etf.Tuple{etf.Atom("gonode"), etf.Atom("reply"), len(terms)})
    //         return
    //     }

    //     // Provide it to call via RPC with `rpc:call(gonode@localhost, go_rpc, call, [as, qwe])`
    //     err = enode.RpcProvide("go_rpc", "call", eClos)
    //     if err != nil {
    //         log.Printf("Cannot provide function to RPC: %s", err)
    //     }
    // }

    // Wait to stop
    <-completeChan

    log.Println("进程结束了=========: %#v", serverName)
    return
}

// call back start ============================================================

// Init
func (gs *srv) Init(args ...interface{}) {
    // log.Printf("Init: %#v", args)

    // Store first argument as channel
    // gs.completeChan = args[0].(chan bool)
}

// HandleCast
// Call `gen_server:cast({go_srv, gonode@localhost}, stop)` at Erlang node to stop this Go-node
func (gs *srv) HandleCast(message *etf.Term) {
    log.Printf("HandleCast: %#v", *message)

    var self_pid etf.Pid = gs.Self

    // Check type of message
    switch req := (*message).(type) {
    case etf.Tuple:
        from := req[1].(etf.Pid)

        if len(req) > 0 {
            switch act := req[0].(type) {
                case etf.Atom:
                    if string(act) == "ping" {
                        reply_msg := etf.Term(etf.Tuple{etf.Atom("pong"), etf.Pid(self_pid)})
                        gs.Node.Send(from, reply_msg)
                    }
                case etf.Tuple:
                    // 调用 Cast 控制器逻辑　
                    cast := getCast(string(act[0].(etf.Atom)))
                    cast.Excute(from, gs.Node, act)
            }
        }

    case etf.Atom:
        // If message is atom 'stop', we should say it to main process
        if string(req) == "stop" {
            if gs.serverName != SrvName {
                // log.Printf("结束进程: %#v", gs.serverName)
                log.Printf("结束进程, server name: %#v", gs.serverName)
                gs.Node.Unregister(etf.Atom(gs.serverName))
                // gs.completeChan <- true
            }
        }
    }
}

// HandleCall
// Call `gen_server:call({go_srv, gonode@localhost}, Message)` at Erlang node
func (gs *srv) HandleCall(message *etf.Term, from *etf.Tuple) (reply *etf.Term) {
    // 尝试从message 中提取信息
    switch req := (*message).(type) {
    case etf.Tuple:
        if len(req) > 0 {
            // 调用 Call 控制器逻辑
            call := getCall(string(req[0].(etf.Atom)))
            reply = call.Excute(req)
        }
    case etf.Atom:
        if string(req) == "start_goroutine" {
            // 启动一个新进程, 进程编号依次累加, 以gen_server,简称为前辍
            serverId += 1
            serverName := "gs_" + strconv.Itoa(serverId)
            log.Printf("new goroutine 创建新协程, server name: %#v", serverName)

            eSrv := new(srv)
            gs.Node.Spawn(eSrv)
            eSrv.Node.Register(etf.Atom(serverName), eSrv.Self)
            eSrv.serverName = serverName

            replyTerm := etf.Term(etf.Tuple{etf.Atom("ok"), etf.Atom(serverName)})
            reply = &replyTerm

        } else if string(req) == "info" {
            // 查看节点上启动了的进程信息
            registered := gs.Node.Registered()

            // 协程总数量
            tupleNumGoroutine := etf.Tuple{etf.Atom("num_goroutine"), runtime.NumGoroutine()}

            // 由 erlang 注册的进程的列表, 进程数量
            var listRegisterdGoroutine etf.List
            listRegisterdGoroutineCount := 0

            // 包内部创建的协程列表，数量
            var listRegisterdGoroutineSys etf.List
            listRegisterdGoroutineSysCount := 0

            for i:=0; i<len(registered); i++{
                if strings.Contains(string(registered[i]), "gs_") {
                    listRegisterdGoroutine = append(listRegisterdGoroutine, registered[i])
                    listRegisterdGoroutineCount += 1
                } else {
                    listRegisterdGoroutineSys = append(listRegisterdGoroutineSys, registered[i])
                    listRegisterdGoroutineSysCount += 1
                }
            }
            tupleServerName := etf.Tuple{etf.Atom("registered_goroutine_name"), listRegisterdGoroutineCount, listRegisterdGoroutine}
            tupleServerNameSys := etf.Tuple{etf.Atom("registered_goroutine_name_sys"), listRegisterdGoroutineSysCount, listRegisterdGoroutineSys}

            // 返回
            replyTerm := etf.Term(etf.Tuple{etf.Atom("ok"), tupleNumGoroutine, tupleServerName, tupleServerNameSys})
            reply = &replyTerm
        }
    }

    return
}

// HandleInfo
func (gs *srv) HandleInfo(message *etf.Term) {
    log.Printf("HandleInfo: %#v", *message)
}

// Terminate
func (gs *srv) Terminate(reason interface{}) {
    log.Printf("Terminate: %#v", reason.(int))
}

// call back end ============================================================================

func setup_logging() {
    // Enable logging only if setted -log option
    if LogFile != "" {
        var f *os.File
        if f, err = os.Create(LogFile); err != nil {
            log.Fatal(err)
        }
        log.SetOutput(f)
    }
}

func write_pid() {
    log.Println("process pid:", os.Getpid())
    if PidFile != "" {
        file, err := os.Create(PidFile)
        if err != nil {
            log.Fatal(err)
        }
        defer file.Close()
        w := bufio.NewWriter(file)
        fmt.Fprintf(w, "%v", os.Getpid())
        w.Flush()
        log.Println("write pid in", PidFile)
    }
}

