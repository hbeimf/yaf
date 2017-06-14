%%%-------------------------------------------------------------------
%% @doc functions
%% @end
%%%-------------------------------------------------------------------

-module(link).
-compile(export_all).
% -export([years/0, today/0]).




run() ->
    Dir = "/web/yaf/doc/demo.html",
    Dir1 = "/web/yaf/doc/demo1.html",

    {ok, Page} = lib_fun:file_get_contents(Dir),

    % R = re:run(Page, "<table id=\"FundHoldSharesTable\">(.*)</table>", [{capture, all, list}]),
    Html = go:iconv(Page, 'gb2312', 'utf-8'),

    lib_fun:file_put_contents(Dir1, Html),

    % Html.

    % R = re:run(Html, "<li>(.*)</li>", [{capture, all, list}]),

    R = re:run(Html, "<tr(.*)tr>", [{capture, all, list}]),

    % io:format("~n ~ts ~n", [R]),

    R.
    % Page.
    % ok.

set_demo_page() ->
    Dir = "/web/yaf/doc/demo.html",

    {Year, Jd} = today(),
    Code = "002154",

    Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/"++lib_fun:to_str(Code)++".phtml?year="++lib_fun:to_str(Year)++"&jidu="++lib_fun:to_str(Jd),
    io:format("~n~p~n~n", [Link]),

    Page = http_get(Link),


    lib_fun:file_put_contents(Dir, Page).

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
    {{ThisYear, _ThisMonth, _},_} = lib_fun:timestamp_to_datetime(lib_fun:time()),
    ThisYear.

this_month() ->
    {{_, ThisMonth, _},_} = lib_fun:timestamp_to_datetime(lib_fun:time()),
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

