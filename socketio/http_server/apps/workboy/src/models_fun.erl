-module(models_fun).

% 2016-07-24
% -compile(export_all).

% 公共函数

-export([
		% print_var/1,
         print_list/1,
         cut_list/1,
         to_float/1,
         get_sum_list/1,
         get_sum_list/2,
         get_code/0,
         get_code_today_list/1,
         get_wave_list/1
        ]).


print_list(GroupList) ->
	lists:foreach(fun(SubList) -> 
		io:format("~p~n~n", [SubList]),
		ok
	end, GroupList),
	ok.

% print_var(Var) ->
% 	io:format("~nval:~p~n", [Var]).

%% 得到垂直分割列表的区间及id号
cut_list(List) when length(List) >= 2 ->
	[{_TimeMin, _StrTimeMin, ClosePriceMin}|TailList] = lists:keysort(3, List),
	{_TimeMax, _StrTimeMax, ClosePriceMax} = lists:last(TailList),
	list_gap(ClosePriceMin, ClosePriceMax);
cut_list(_List) ->
	[].

list_gap(StartPrice, EndPrice) ->
	NextPrice = StartPrice + list_gap_add() * StartPrice,
	Id = 1,
	list_gap(Id, StartPrice, NextPrice, EndPrice, []).

list_gap(Id, StartPrice, NextPrice, EndPrice, []) when NextPrice < EndPrice ->
	NextPrice1 = NextPrice + list_gap_add() * NextPrice,
	NextId = Id + 1,
	list_gap(NextId, NextPrice, NextPrice1, EndPrice, [{Id, to_float(StartPrice), to_float(NextPrice)}]);
list_gap(Id, StartPrice, NextPrice, EndPrice, ReplyList) when NextPrice < EndPrice ->
	NextPrice1 = NextPrice + list_gap_add() * NextPrice,
	NextId = Id + 1,
	list_gap(NextId, NextPrice, NextPrice1, EndPrice, [{Id, to_float(StartPrice), to_float(NextPrice)}|ReplyList]);
list_gap(Id, StartPrice, _NextPrice, EndPrice, ReplyList) ->
	[{Id, to_float(StartPrice), to_float(EndPrice)}|ReplyList].

%  一个涨停 0.1
list_gap_add() ->
	0.02.

to_float(L) -> 
	list_to_float(hd(io_lib:format("~.2f",[L]))).

get_sum_list(Code) ->
	Sql = "select * from gp_history where code = '" ++ lib_fun:to_str(Code) ++ "'",
	List = lib_fun:get_assoc(Sql),
	lists:foldl(fun(L, {SumPrice, ReplyList}) -> 
		{_, Time} = lists:keyfind(<<"time">>, 1, L),
		{_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
		{_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),
		SumPrice1 = SumPrice + ClosePrice,
		{SumPrice1, [{Time, StrTime, ClosePrice}|ReplyList]}
	end, {0, []}, List).


get_wave_list(Code) ->
	Sql = "select * from gp_history where code = '" ++ lib_fun:to_str(Code) ++ "'",
	List = lib_fun:get_assoc(Sql),
	lists:foldl(fun(L, {SumPrice, ReplyList}) -> 
		{_, Time} = lists:keyfind(<<"time">>, 1, L),
		{_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
		{_, OpenPrice} = lists:keyfind(<<"openPrice">>, 1, L),
		{_, HighPrice} = lists:keyfind(<<"highPrice">>, 1, L),
		{_, LowerPrice} = lists:keyfind(<<"lowerPrice">>, 1, L),
		{_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),
		SumPrice1 = SumPrice + ClosePrice,
		{SumPrice1, [{Time, StrTime, OpenPrice, ClosePrice, HighPrice, LowerPrice}|ReplyList]}
	end, {0, []}, List).




get_sum_list(Code, Num) ->
	Sql = "select * from gp_history where code = '" ++ lib_fun:to_str(Code) ++ "' order by id desc limit "++ lib_fun:to_str(Num),
	List = lib_fun:get_assoc(Sql),
	lists:foldl(fun(L, {SumPrice, ReplyList}) -> 
		{_, Time} = lists:keyfind(<<"time">>, 1, L),
		{_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
		{_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),
		SumPrice1 = SumPrice + ClosePrice,
		{SumPrice1, [{Time, StrTime, ClosePrice}|ReplyList]}
	end, {0, []}, List).

get_code()->
	Sql = "select code,name from m_gp_list",
	lib_fun:get_assoc(Sql).
	


get_code_today_list(Code) ->
	Sql = "select openPrice,closePrice,highPrice,lowerPrice,time,str_time from gp_history where code = '" ++ lib_fun:to_str(Code) ++ "' order by time desc limit 1",
	[Reply] = lib_fun:get_assoc(Sql),
	Reply.


% [{<<"id">>,4184971},
%        {<<"openPrice">>,16.43},
%        {<<"closePrice">>,16.4},
%        {<<"highPrice">>,16.48},
%        {<<"lowerPrice">>,16.38},
%        {<<"time">>,1473782400},
%        {<<"str_time">>,<<"2016-09-14">>},
%        {<<"code">>,<<"sh600000">>}]
















