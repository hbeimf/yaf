rebar3 relup doc

发布第一个版本: ==================================================


$ rebar3 release
$ rebar3 tar
$ mkdir run
$ cd run/

$ cp /web/erl/websocket_and_socketio_upgrade_protobuf_demo/http_server/_build/default/rel/http_server/http_server-0.1.1.tar.gz ./
$ tar xzvf ./http_server-0.1.1.tar.gz
$ ./bin/http_server console


(http_server@127.0.0.1)1> application:which_applications().



假设http_server 从0.1.1 版本改到了　0.1.2

发布第二个版本:====================================================


$ rebar3 release
 #产生.appup文件
$ rebar3 appup generate

$ rebar3 relup
$ rebar3 tar

/run$ cd releases/
$ cp /web/erl/websocket_and_socketio_upgrade_protobuf_demo/http_server/_build/default/rel/http_server/http_server-0.1.2.tar.gz ./

/run$ ./bin/http_server upgrade 0.1.2
/run$ ./bin/http_server downgrade 0.1.1






























