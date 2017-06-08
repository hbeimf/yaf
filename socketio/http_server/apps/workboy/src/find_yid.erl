-module(find_yid).

% 2016-07-24
% -compile(export_all).

-export([
         code/0,
         code/1,
         get_code/0
         % add_yid/1
        ]).

get_code()->
	Sql = "select code,name from m_gp_list",
	mysql:get_assoc(Sql).

code() ->
	Code = <<"sh600000">>,
	code_detail(Code).

code(Code) ->
	code_detail(Code).

code_detail(Code) ->
	{_Sum, List} = get_sum_list(Code),
	YearsNum = find_years(List),

	L = get_code_today_list(Code),

	{_, OpenPrice} = lists:keyfind(<<"openPrice">>, 1, L),
	{_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
	{_, HighPrice} = lists:keyfind(<<"highPrice">>, 1, L),
	{_, LowerPrice} = lists:keyfind(<<"lowerPrice">>, 1, L),
	{_, Time} = lists:keyfind(<<"time">>, 1, L),
	{_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),

	% #{
	% 	code=>Code,
	% 	yid=>find_current_yid(List), 
	% 	open_price=>OpenPrice, 
	% 	close_price=>ClosePrice, 
	% 	high_price=>HighPrice, 
	% 	lower_price=>LowerPrice, 
	% 	time=>Time, 
	% 	str_time=>StrTime, 
	% 	years_num=>YearsNum}.	

	{find_current_yid(List), OpenPrice, ClosePrice, HighPrice, LowerPrice, Time, StrTime, YearsNum}.


find_years([]) ->
	0;
find_years(List) ->
	Years = lists:foldl(fun({Time, _, _}, ReplyList) -> 
		{{Year, _, _}, _} = timestamp_to_datetime(Time),
		case lists:member(Year, ReplyList) of
			true -> 
				ReplyList;
			_ ->
				[Year|ReplyList]
		end
	end, [], List),
	length(Years).



find_current_yid(List) when length(List) > 2 ->
	{_Time, _StrTime, ClosePrice} = get_last_pos(List),
	CutList = cut_list(List),

	[R|_] = lists:foldl(fun({Id, StartPrice, EndPrice}, ReplyList) -> 
		case StartPrice =< ClosePrice andalso ClosePrice =< EndPrice of
			true ->
				[Id|ReplyList];
			_ ->
				ReplyList
		end
	end, [], CutList),
	R;
find_current_yid(_List) ->
	0.

get_last_pos(List) ->
	[LastPos|_TailList] = lists:reverse(lists:keysort(1, List)),
	LastPos.

% table fun -----------------------------------------

get_sum_list(Code) ->
	Sql = "select * from gp_history where code = '" ++ to_str(Code) ++ "'",
	List = mysql:get_assoc(Sql),

	lists:foldl(fun(L, {SumPrice, ReplyList}) -> 
		{_, Time} = lists:keyfind(<<"time">>, 1, L),
		{_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
		{_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),
		SumPrice1 = SumPrice + ClosePrice,
		{SumPrice1, [{Time, StrTime, ClosePrice}|ReplyList]}
	end, {0, []}, List).


get_code_today_list(Code) ->
	Sql = "select openPrice,closePrice,highPrice,lowerPrice,time,str_time from gp_history where code = '" ++ to_str(Code) ++ "' order by time desc limit 1",
	[Reply] = mysql:get_assoc(Sql),
	Reply.


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


% lib fun --------------------------------------------
to_str(X) when is_list(X) -> X;
to_str(X) when is_atom(X) -> atom_to_list(X);
to_str(X) when is_binary(X) -> binary_to_list(X);
to_str(X) when is_integer(X) -> integer_to_list(X);
to_str(X) when is_float(X) -> float_to_list(X).


timestamp_to_datetime(Timestamp) ->  
	calendar:gregorian_seconds_to_datetime( 8*60*60 + Timestamp +  calendar:datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}})). 


