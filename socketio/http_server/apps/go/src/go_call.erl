%%%-------------------------------------------------------------------
%% @doc go public API
%% @end
%%%-------------------------------------------------------------------

-module(go_call).
-compile(export_all).

%% Application callbacks

% api =====================================

start_goroutine() ->
    go_server:start_goroutine().

stop_goroutine(GoMBox) ->
    go_server:stop_goroutine(GoMBox).


info() ->

    go_server:info().

http_get(Url) ->
    case httpc:request(get, {Url, []},
                        [{autoredirect, true}, {timeout, 60000}, {version, "HTTP/1.1"}],
                        [{body_format, binary}]) of
            {ok, {_,_, Body}}->
                Body;
            {error, _Reason} ->
                <<"">>
    end.

parse_list(List, Add) ->
    {ok, GoMBox} = application:get_env(go, go_mailbox),
    % Call = {list, List, 0.1},
    Call = {list, List, Add},
    gen_server:call(GoMBox, Call).


iconv(Str, From, To) ->
    {ok, GoMBox} = application:get_env(go, go_mailbox),
    % From = 'gb2312',
    % To = 'utf-8',

    Call = {iconv, Str, From, To},
    {ok, ReplyStr} = gen_server:call(GoMBox, Call),
    ReplyStr.

% demo ========================================================================

% t() ->
%     {ServerName, Host, Pid} = start_goroutine(),

%      % {ok, GoMBox} = application:get_env(go, go_mailbox),
%     % GoMBox = start_goroutine(),

%     Utf8Name = unicode:characters_to_binary("xiaomin小明"),
%     % Json = jsx:encode(#{name=>Utf8Name, email=><<"123456@gmail.com">>, age=> 1}),
%     Json = jsx:encode(#{name=>Utf8Name, email=><<"123456@gmail.com">>, age=> 1, list=>[1,2,3,5]}),

%     Call = {demo, Json},

%     % GoMBox = {ServerName, Host},
%     GoMBox = {Pid, Host},

%     % GoMBox = Pid,


%     Reply = gen_server:call(GoMBox, Call),

%     stop_goroutine(GoMBox),

%     Reply.



echo_zh() ->
    Utf8Name = unicode:characters_to_binary("xiaomin小明"),
    io:format("~ts~n", [Utf8Name]).


call() ->
    % {ok, GoMBox} = application:get_env(go, go_mailbox),
    GoMBox = start_goroutine(),

    Utf8Name = unicode:characters_to_binary("xiaomin小明"),
    % Json = jsx:encode(#{name=>Utf8Name, email=><<"123456@gmail.com">>, age=> 1}),
    Json = jsx:encode(#{name=>Utf8Name, email=><<"123456@gmail.com">>, age=> 1, list=>[1,2,3,5]}),

    Call = {demo, Json},
    Reply = gen_server:call(GoMBox, Call),

    stop_goroutine(GoMBox),

    Reply.



call_wrong() ->
    GoMBox = start_goroutine(),

    Utf8Name = unicode:characters_to_binary("xiaomin小明"),
    Json = jsx:encode(#{name=>Utf8Name, email=><<"123456@gmail.com">>, age=> 1}),

    Call = {wrong, Json},
    Reply = gen_server:call(GoMBox, Call),
    stop_goroutine(GoMBox),

    Reply.

% ttt() ->
%     Dir1 = code:lib_dir(go, priv) ++ "/utf-8.html",
%     lib_fun:file_get_contents(Dir1),

%     io:format("~ts~n", [Utf8Name]).


tt() ->
    % gb2312 的网页
    Url = "http://down.chinaz.com/soft/34159.htm",
    % Url = "https://www.baidu.com/",

    Html = http_get(Url),


    Dir = code:lib_dir(go, priv) ++ "/gb2312.html",
    % error_logger:info_msg("dir XXX  ~p~n", [Dir]),
    % lib_fun:file_put_contents(Dir, Html),
    file:write_file(Dir, Html),

    % Html1 = unicode:characters_to_binary(Html),

    % {ok, GoMBox} = application:get_env(go, go_mailbox),

    From = 'gb2312',
    To = 'utf-8',
    Html2 = iconv(Html, From, To),

    % Call = {iconv, Html, From, To},
    % {ok, Html2} = gen_server:call(GoMBox, Call),


    Dir1 = code:lib_dir(go, priv) ++ "/utf-8.html",
    % error_logger:info_msg("dir XXX  ~p~n", [Dir]),
    % lib_fun:file_put_contents(Dir, Html),
    file:write_file(Dir1, Html2),


    % io:format("~ts ~n", [unicode:characters_to_binary(Html2)]),

    ok.


% curl() ->
%     % Url = "https://www.baidu.com/",

%     Url = "http://down.chinaz.com/soft/34159.htm",
%     {ok, GoMBox} = application:get_env(go, go_mailbox),

%     Utf8Url = unicode:characters_to_binary(Url),

%     Call = {curl, Utf8Url},
%     % Reply = gen_server:call(GoMBox, Call),

%     {ok, Html2} = gen_server:call(GoMBox, Call),

%     io:format("~ts ~n", [Html2]),


%     ok.


% iconv() ->
%     % Url = "https://www.baidu.com/",
%     Url = "http://down.chinaz.com/soft/34159.htm",
%     {ok, GoMBox} = application:get_env(go, go_mailbox),

%     Utf8Url = unicode:characters_to_binary(Url),

%     From = 'gb2312',
%     To = 'utf-8',
%     Call = {iconv, Utf8Url, From, To},

%     Reply = gen_server:call(GoMBox, Call),
%     Reply.

call_list() ->
    % {ok, GoMBox} = application:get_env(go, go_mailbox),
    % GoMBox = start_goroutine(),

    Json = [{1479823672, 4},
            {1453881959, 1},
            {1453881963, 3.12},

            {1453881968, 4.12},
            {1369052639, 5.12},
            {1369052610, 5.12},

            {1369052611, 5.12},
            {1369052612, 5.12},
            {1369052613, 5.12},

            {1454782744, 3.1415},
            {1454572492, 3.1415},
            {1469896558, 3.1415},

            {1369052614, 5.12},
            {1369052615, 3.1},
            {1369052616, 1.5}],

    parse_list(Json, 0.1).

    % Json = [{1, 333}, {2, 2222}],

    % Call = {list, Json, 0.1},

    % lists:foreach(fun(_X) ->
    %     Reply = gen_server:call(GoMBox, Call),
    %     io:format("reply================:~n~p~n~n", [Reply])
    % end, lists:seq(1, 2)),

    % Reply = gen_server:call(GoMBox, Call),

    % stop_goroutine(GoMBox),

    % io:format("reply================:~n~p~n~n", [Reply]),
    % Reply.
    % ok.







%%====================================================================
%% Internal functions
%%====================================================================
