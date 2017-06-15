%%%-------------------------------------------------------------------
%% @doc functions
%% @end
%%%-------------------------------------------------------------------

-module(link).
-compile(export_all).
% -export([years/0, today/0]).

run3() ->
    % Dir = "/web/yaf/doc/demo.html",
    Dir1 = "/web/yaf/doc/demo.html",

    {ok, Html} = lib_fun:file_get_contents(Dir1),


    case re:run(Html, "<table id=\"FundHoldSharesTable\">(.*)</table>",
        [{capture, all, binary}, global, dotall, ungreedy]) of
        {_, Matches} ->
            lists:foreach(fun(Match) ->
                % io:format("=================================== ~n"),
                [Table|_] = Match,
                % io:format("~n ~ts ~n", [M]),
                % write_match(M),
                tr(Table),
                ok
            end, lists:reverse(Matches));
        _ ->
            ok
    end,
    ok.


tr(Table) ->
    case re:run(Table, "<tr(.*)tr>",
        [{capture, all, binary}, global, dotall, ungreedy]) of
        {_, Matches} ->
            lists:foreach(fun(Match) ->
                io:format("=================================== ~n"),
                [Tr|_] = Match,
                % io:format("~n~n~n ~ts ~n", [Tr]),
                td(Tr),
                % write_match(M),
                ok
            end, lists:reverse(Matches));
        _ ->
            ok
    end,

    ok.


td(Tr) ->
    case re:run(Tr, "<td(.*)td>",
        [{capture, all, binary}, global, dotall, ungreedy]) of
        {_, Matches} ->

            case length(Matches) of
                7 ->
                    io:format("~p~n", [erlang:length(Matches)]),

                    io:format("~ts~n", [Tr]),

                    % io:format("~ts~n", [lists:nth(1, Matches)]),
                    % io:format("~ts~n", [lists:nth(2, Matches)]),
                    % io:format("~ts~n", [lists:nth(3, Matches)]),
                    % io:format("~ts~n", [lists:nth(4, Matches)]),
                    % io:format("~ts~n", [lists:nth(5, Matches)]),
                    % io:format("~ts~n", [lists:nth(6, Matches)]),
                    % io:format("~ts~n", [lists:nth(7, Matches)]),

                    lists:foreach(fun(M) ->
                        % [H|_] = M,
                        io:format("--------------------- ~n"),
                        io:format("~p~n", [go:trim(lib_fun:to_str(strip_tags(lists:nth(1, M))))]),
                        ok
                    end, Matches),


                    ok;
                _ ->
                    io:format("~ts~n", [Tr]),

                    ok
            end,



            ok;

        _ ->
            ok
    end,



    ok.


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

    {ok, Html} = lib_fun:file_get_contents(Dir1),


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

    {ok, Html} = lib_fun:file_get_contents(Dir1),


    {_, R} = re:run(Html, "<tr>(.*)</tr>", [{capture, all, binary}, global, dotall]),

    lists:foreach(fun(X) ->
        io:format("=================================== ~n"),
        io:format("~n ~ts ~n", [X])
    end, lists:reverse(R)),

    ok.



run() ->
    % Dir = "/web/yaf/doc/demo.html",
    Dir1 = "/web/yaf/doc/demo1.html",

    {ok, Html} = lib_fun:file_get_contents(Dir1),

    % R = re:run(Page, "<table id=\"FundHoldSharesTable\">(.*)</table>", [{capture, all, list}]),
    % Html = go:iconv(Page, 'gb2312', 'utf-8'),

    % lib_fun:file_put_contents(Dir1, Html),

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

    % io:format("~ts", [lib_fun:to_binary(R)]).
    % Page.
    ok.

write_match(Match) ->
    Dir1 = "/web/yaf/doc/list1.html",
    lib_fun:file_put_contents(Dir1, Match).

write_log(Report) ->
  % Dir = root_dir() ++ "log/cache_"++ random() ++".html",
  Dir = "/web/yaf/doc/list.html",
  {ok, S} = file:open(Dir, write),
  io:format(S, "~p~n", [Report]),
  file:close(S),
  % {ok, Str} = lib_fun:file_get_contents(Dir),
  % log(Str),
  % file:delete(Dir),
  ok.




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

