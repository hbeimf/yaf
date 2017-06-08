%%%-------------------------------------------------------------------
%% @doc functions
%% @end
%%%-------------------------------------------------------------------

-module(spider).
-compile(export_all).
% -export([years/0, today/0]).


run() -> 
    Sql = "SELECT code,name FROM m_gp_list",
    mysql:get_assoc(Sql),

    % Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/{$code1}.phtml?year={$year}&jidu={$jd}";

    ok.


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

