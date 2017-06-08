%%%-------------------------------------------------------------------
%% @doc go public API
%% @end
%%%-------------------------------------------------------------------

-module(go).
-compile(export_all).

%%====================================================================
%% Call Api functions
%% 同步消息发送
%%====================================================================
% info() ->
%     go_name_server:info().
parse_html() ->
    Html = "html",
    parse_html(Html).
parse_html(Html) ->
    Call = {str, parse_html, Html},
    call(Call).

info() ->
    Call = info,
    call(Call).

parse_list(List) ->
    parse_list(List, 0.1).

parse_list(List, Add) ->
    Call = {list, List, Add},
    call(Call).



str_replace() ->
    str_replace("hello world!!", "e", "XX").
str_replace(StrRes, FindStr, ReplaceTo) ->
    Call = {str, str_replace, lib_fun:to_str(StrRes), FindStr, ReplaceTo},
    {ok, NewString} = call(Call),
    NewString.


% From = 'gb2312',
% To = 'utf-8',
iconv(Str, From, To) ->
    case string:len(Str) > 3000 of
        true ->
            long_string_iconv(Str, From, To);
        _ ->
            short_string_iconv(Str, From, To)
    end.

short_string_iconv(Str, From, To) ->
    Call = {iconv, lib_fun:to_binary(Str), From, To},
    {ok, ReplyStr} = call(Call),
    ReplyStr.

long_string_iconv(String, From, To) ->
    L = cut_str(lib_fun:to_str(String), 3000),
    List = lists:foldl(fun(Str, Reply) ->
      R = short_string_iconv(Str, From, To),
      [R|Reply]
    end, [], L),
    lib_fun:implode(List, "").

cut_str(Str, Len) ->
    cut_str([], Str, Len).

cut_str(ReplyList, Str, Len) ->
    StrLen = string:len(Str),
    case StrLen < Len of
        true ->
            [Str|ReplyList];
        _ ->
            Head = string:substr(Str, 1, Len),
            Tail = string:substr(Str, Len+1, StrLen - Len),
            cut_str([Head|ReplyList], Tail, Len)
    end.

% str(Str) ->
%     Call = {str, Str},
%     call(Call).

call(Call) ->
    GoMBox = go_name_server:get_gombox(),
    gen_server:call(GoMBox, Call).

%%====================================================================
%% Cast Api functions
%% 异步消息发送　
%%====================================================================
cast() ->
    List = [{name, "xiaomin"}, {email, "123456@qq.com"}],
    Cast = {list, List},
    send_cast(Cast).


send_cast(Cast) ->
    GoMBox = go_name_server:get_gombox(),
    go_name_server:send_cast(GoMBox, Cast),
    ok.


t() ->
    lists:foreach(fun(I) ->
        GoMBox = go_name_server:get_gombox(),
        io:format("~p ~p　~n", [I, GoMBox])
    end, lists:seq(1, 100)).


%%====================================================================
%% Call Api functions
%% erlang 实现的函数
%%====================================================================

http_get(Url) ->
    case httpc:request(get, {Url, []},
                        [{autoredirect, true},
                         {timeout, 60000},
                         {version, "HTTP/1.1"}],
                        [{body_format, binary}]) of
            {ok, {_,_, Body}}->
                Body;
            {error, _Reason} ->
                <<"">>
    end.

% 用在rebar3发布的配置文件中
apps() ->
    Apps = application:which_applications(),

    AppList = lists:foldl(fun({App, _, _}, ReleaseAppList) ->
        [App|ReleaseAppList]
    end, [], Apps),

    io:format("~n~p~n~n", [AppList]),
    ok.




d() ->
    % Html = http_get("http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/600031.phtml?year=2017&jidu=2"),
    % Html = http_get("http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/sh600031.phtml?year=2017&jidu=2"),

    % Html = http_get("https://www.baidu.com"),

    % Html1 = iconv(Html, 'gb2312', 'utf-8'),
    % Html1.
    Dir = code:priv_dir(go) ++ "/2.html",
    {_, F} = lib_fun:file_get_contents(Dir),
    parse_html(lib_fun:to_binary(F)),

    % Str = lib_fun:to_str(F),

    % string:substr("Hello World",4,5).

    % string:len(Str),



    % iconv(F, gb2312, 'utf-8//IGNORE'),
    % iconv(F, 'gb2312', 'utf-8'),

    ok.
    % lib_fun:file_put_contents(Dir, Html).


% cut_str(Str, Size) ->
%     cut_str(Str, string:len(Str)).

% cut_str(Str, Len) ->
%     StrLen = string:len(Str),
%     case StrLen < Len of
%         true ->
%             [Str];
%         _ ->
%             Head = string:substr(Str, 1, Len),
%             Tail = string:substr(Str, Len+1, StrLen - Len),
%             [Head|cut_str(Tail, Len)]
%     end.

% d() ->
%     Dir = code:priv_dir(go) ++ "/1.html",
%     {_, H} = lib_fun:file_get_contents(Dir),
%     % L = cut_str(lib_fun:to_str(H), 3000),
%     % List = lists:foldl(fun(Str, Reply) ->
%     %   R = iconv(Str, 'gb2312', 'utf-8'),
%     %   [R|Reply]
%     % end, [], L),
%     % Con = lib_fun:implode(List, ""),

%     Con = long_string_iconv(H, 'gb2312', 'utf-8'),
%     Dir2 = code:priv_dir(go) ++ "/2.html",
%     lib_fun:file_put_contents(Dir2, Con).

    % parse_html(lib_fun:to_binary(H)).



