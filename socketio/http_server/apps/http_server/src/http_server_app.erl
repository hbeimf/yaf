% %%%-------------------------------------------------------------------
% %% @doc http_server public API
% %% @end
% %%%-------------------------------------------------------------------

-module(http_server_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            %% 静态文件请求
            {"/", cowboy_static, {priv_file, http_server, "index_chat.html"}},
            {"/io", cowboy_static, {priv_file, http_server, "index_io.html"}},
            {"/ws", cowboy_static, {priv_file, http_server, "index_ws.html"}},
            {"/pb", cowboy_static, {priv_file, http_server, "index_pb.html"}},
            {"/static/[...]", cowboy_static, {priv_dir, http_server, "static"}},
            {"/public/[...]", cowboy_static, {priv_dir, http_server, "public"}}, %% 静态文件请求 js , css, images 等
                    
            %% 动态请求
            {"/page/[...]", handler_page, []},
            {"/protocol.proto", handler_protobuff, []},
            {"/websocket", handler_ws, []},
            {"/socket.io/1/[...]",
              socketio_handler,
              [socketio_session:configure([{heartbeat, 5000},
                                           {heartbeat_timeout, 30000},
                                           {session_timeout, 30000},
                                           {callback, handler_io},
                                           {protocol, socketio_data_protocol}])]}
        ]}
    ]),
    cowboy:start_http(socketio_http_listener, 100, [{host, "127.0.0.1"},
                                                    {port, 8080}], [{env, [{dispatch, Dispatch}]}]),
    % demo_mgr:start_link(),
    %  改点注释啥 的,做升级测试
    http_server_sup:start_link().

stop(_State) ->
    ok.

