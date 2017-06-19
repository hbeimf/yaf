%%%-------------------------------------------------------------------
%% @doc functions
%% @end
%%%-------------------------------------------------------------------

-module(link).
-compile(export_all).
% -export([years/0, today/0]).


% CREATE TABLE `sina_web_page` (
%   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
%   `info_key` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '股票名称:code:year:jd',
%   `url` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '页面链接',
%   `http_code` int(11) DEFAULT '0' COMMENT 'http code',
%   `html_page` longtext COLLATE utf8_unicode_ci COMMENT 'html page',
%   `flg` int(11) DEFAULT '0' COMMENT 'flg|1:已解析,0:未解析',
%   PRIMARY KEY (`id`),
%   KEY `IDX_tesinx_info_key` (`info_key`),
%   KEY `IDX_flg` (`flg`),
%   KEY `IDX_url` (`url`)
% ) ENGINE=InnoDB AUTO_INCREMENT=229872 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='新浪采集的页面｛k线数据原始页面｝'


% CREATE TABLE `m_gp_list` (
%   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
%   `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'code',
%   `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
%   PRIMARY KEY (`id`)
% ) ENGINE=InnoDB AUTO_INCREMENT=2855 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='股票列表'

% CREATE TABLE `gp_history` (
%   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
%   `openPrice` float(9,3) DEFAULT '0.000' COMMENT '开盘价',
%   `closePrice` float(9,3) DEFAULT '0.000' COMMENT '收盘价',
%   `highPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最高价',
%   `lowerPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最低价',
%   `time` int(11) DEFAULT '0' COMMENT '时间',
%   `str_time` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'str_time',
%   `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'code',
%   PRIMARY KEY (`id`),
%   KEY `IDX_code_time` (`code`,`str_time`)
% ) ENGINE=InnoDB AUTO_INCREMENT=7178660 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='历年股票数据'



run3() ->
    % Dir = "/web/yaf/doc/demo.html",
    Dir1 = "/web/yaf/doc/demo1.html",

    {ok, Html} = go_lib:file_get_contents(Dir1),
    table(<<"xx">>, Html).

link(Code, Link) ->
    io:format("+++++: ~p~n", [Link]),
    Html = go_lib:http_get(Link),
    table(Code, Html),
    ok.


table(Code, Html) ->
    case re:run(Html, "<table id=\"FundHoldSharesTable\">(.*)</table>",
        [{capture, all, binary}, global, dotall, ungreedy]) of
        {_, Matches} ->
            lists:foreach(fun(Match) ->
                [Table|_] = Match,
                tr(Code, Table),
                ok
            end, lists:reverse(Matches));
        _ ->
            ok
    end.

tr(Code, Table) ->
    case re:run(Table, "<tr(.*)tr>",
        [{capture, all, binary}, global, dotall, ungreedy]) of
        {_, Matches} ->
            lists:foldr(fun(Match, Res) ->
                [Tr|_] = Match,
                td(Code, Tr),
                Res
            end, [], Matches),
            ok;
        _ ->
            ok
    end.


td(Code, Tr) ->
    case re:run(Tr, "<td(.*)td>",
        [{capture, all, binary}, global, dotall, ungreedy]) of
        {_, Matches} ->
            Fields = lists:foldl(fun(M, Res) ->
                Field = go:trim(go_lib:to_str(strip_tags(lists:nth(1, M)))),
                [Field|Res]
            end, [], Matches),
            print(Code, Fields),
            ok;
        _ ->
            ok
    end.

print(Code, List) ->
    Last = lists:last(List),
    case go:contains(Last, "-") of
        true ->
            % io:format("~p~n", [List]),

            doit_server_add:doit(Code, list_to_tuple(List)),
            ok;
        _ ->
            ok
    end.


% strip_test() ->
%     Html = <<"<td><div align=\"center\">3.780</div></td>">>,
%     strip_tags(Html).

strip_tags(Html) ->
    remove_html_tag(Html).

% http://blog.csdn.net/cuick2013/article/details/38894461
remove_html_tag(Data) ->
    remove_html_tag(Data, 0).

remove_html_tag(Data, Offset) ->
    case re:run(Data, "<.*?>", [dotall, {capture, first, index}, {offset, Offset}]) of
    nomatch ->
        Data;
    {match, [{Index, _Len}]}->
        %% 注意: Offset = Index, 以为长度为Len的数据已经被替换成[]
        remove_html_tag(re:replace(Data, "<.*?>", "", [dotall, {return, binary}]), Index)
    end.


run2() ->
    % Dir = "/web/yaf/doc/demo.html",
    Dir1 = "/web/yaf/doc/demo1.html",

    {ok, Html} = go_lib:file_get_contents(Dir1),


    {_, R} = re:run(Html, "<table id=\"FundHoldSharesTable\">(.*)</table>", [{capture, all, binary}, global, dotall]),

    lists:foreach(fun(X) ->
        io:format("=================================== ~n"),
        % io:format("~n ~ts ~n", [X])
        % io:format("~n ~p ~n", [X])
        lists:foreach(fun(Y) ->
            io:format("~n ~ts ~n", [Y]),
            write_match(Y)
        end, X)


    end, lists:reverse(R)),

    ok.



run1() ->
    % Dir = "/web/yaf/doc/demo.html",
    Dir1 = "/web/yaf/doc/demo1.html",

    {ok, Html} = go_lib:file_get_contents(Dir1),


    {_, R} = re:run(Html, "<tr>(.*)</tr>", [{capture, all, binary}, global, dotall]),

    lists:foreach(fun(X) ->
        io:format("=================================== ~n"),
        io:format("~n ~ts ~n", [X])
    end, lists:reverse(R)),

    ok.



run() ->
    % Dir = "/web/yaf/doc/demo.html",
    Dir1 = "/web/yaf/doc/demo1.html",

    {ok, Html} = go_lib:file_get_contents(Dir1),

    % R = re:run(Page, "<table id=\"FundHoldSharesTable\">(.*)</table>", [{capture, all, list}]),
    % Html = go:iconv(Page, 'gb2312', 'utf-8'),

    % go_lib:file_put_contents(Dir1, Html),

    % Html.

    % R = re:run(Html, "<li>(.*)</li>", [{capture, all, list}]),

    % {ok,MP}=re:compile("<tr(.*)tr>",[multiline, dotall]),
    % {ok,MP}=re:compile("<table id=\"FundHoldSharesTable\">(.*)</table>",[multiline]),
    % {ok,MP}=re:compile("<td(.*)td>",[multiline]),
    % {ok,MP}=re:compile("<table id=\"FundHoldSharesTable\">(.*)</table>",[multiline, dotall, ungreedy]),
    % {ok,MP}=re:compile("<head>(.*)</head>",[multiline, dotall, ungreedy]),


    % R = re:run(Html, "<title>(.*)</title>", [dotall, {capture, all, list}, global]),
    {_, R} = re:run(Html, "<td>(.*)</td>", [{capture, all, binary}, global]),

    lists:foreach(fun(X) ->
        io:format("=================================== ~n"),
        io:format("~n ~ts ~n", [X])
    end, lists:reverse(R)),

    % write_log(R),
    % write_match(R),
    % R.
    % [H|_] = R,
    % [H1|_] = H,

    % % H1.
    % write_log(H1),
    % ok.




    % R = regexp:matches(Html, "<tr(.*)tr>"),
    % R.

    % io:format("~ts", [go_lib:to_binary(R)]).
    % Page.
    ok.

write_match(Match) ->
    Dir1 = "/web/yaf/doc/list1.html",
    go_lib:file_put_contents(Dir1, Match).

write_log(Report) ->
  % Dir = root_dir() ++ "log/cache_"++ random() ++".html",
  Dir = "/web/yaf/doc/list.html",
  {ok, S} = file:open(Dir, write),
  io:format(S, "~p~n", [Report]),
  file:close(S),
  % {ok, Str} = go_lib:file_get_contents(Dir),
  % log(Str),
  % file:delete(Dir),
  ok.




set_demo_page() ->
    Dir = "/web/yaf/doc/demo.html",

    {Year, Jd} = today(),
    Code = "002154",

    Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/"++go_lib:to_str(Code)++".phtml?year="++go_lib:to_str(Year)++"&jidu="++go_lib:to_str(Jd),
    io:format("~n~p~n~n", [Link]),

    Page = http_get(Link),


    go_lib:file_put_contents(Dir, Page).

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

years() ->
    Years = lists:seq(2000,this_year()),
    lists:foldl(fun(Y, Res) ->
        lists:merge(year(Y),Res)
    end, [], Years).


today() ->
    ThisYear = this_year(),
    {ThisYear, lists:max(get_quarter_list(ThisYear))}.

year(Year) ->
    lists:foldl(fun(Jd, Res) ->
        [{Year, Jd}|Res]
    end, [], get_quarter_list(Year)).

this_year() ->
    {{ThisYear, _ThisMonth, _},_} = go_lib:timestamp_to_datetime(go_lib:time()),
    ThisYear.

this_month() ->
    {{_, ThisMonth, _},_} = go_lib:timestamp_to_datetime(go_lib:time()),
    ThisMonth.

get_quarter_list(Year) ->
    ThisYear = this_year(),
    Quarter = case Year =:= ThisYear of
        true ->
            get_quarter(this_month());
        _ ->
            get_quarter(12)
    end,
    lists:seq(1, Quarter).

% 获取季度
get_quarter(Month) when Month =< 3 ->
    1;
get_quarter(Month) when Month =< 6 ->
    2;
get_quarter(Month) when Month =< 9 ->
    3;
get_quarter(_Month) ->
    4.

