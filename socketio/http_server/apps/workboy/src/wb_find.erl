-module(wb_find).

% 2016-07-24
% -compile(export_all).

-export([
         code/0,
         code/1,
         add_yid/1
        ]).

code() ->
	Code = <<"sh600000">>,
	code_detail(Code).

code(Code) ->
	code_detail(Code).

% >   `openPrice` float(9,3) DEFAULT '0.000' COMMENT '开盘价',
%     ->   `closePrice` float(9,3) DEFAULT '0.000' COMMENT '收盘价',
%     ->   `highPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最高价',
%     ->   `lowerPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最低价',
%     ->   `time` int(11) DEFAULT '0' COMMENT '时间',
%     ->   `str_time` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'str_time',
%     ->   KEY index_code (code)



add_yid(List) ->
	% models_fun:print_list(List),

	% Sql = "INSERT INTO gp_high(code, high_yid) VALUES ",
	Sql = "INSERT INTO gp_high(code, high_yid, openPrice, closePrice, highPrice, lowerPrice, time, str_time, year_num) VALUES ",

	Sql1 = lists:foldl(fun({Code, Data}, ReplySql) -> 
		{YId, OpenPrice, ClosePrice, HighPrice, LowerPrice, Time, StrTime, YearsNum} = Data, 

		% ReplySql ++ "('"++lib_fun:to_str(Code)++"', "++lib_fun:to_str(Yid)++"),"
		ReplySql ++ "('"++lib_fun:to_str(Code)++"', "++lib_fun:to_str(YId)++", "
			++lib_fun:to_str(OpenPrice)++", "++lib_fun:to_str(ClosePrice)++", "
			++lib_fun:to_str(HighPrice)++", "++lib_fun:to_str(LowerPrice)++", "
			++lib_fun:to_str(Time)++", '"++lib_fun:to_str(StrTime)++"', "
			++lib_fun:to_str(YearsNum)++"),"

	end, Sql, List),

	Sql2 = lib_fun:rtrim(Sql1, ","),

	truncate_yid(),
	io:format("~p~n", [Sql2]),
	lib_fun:query_sql(Sql2),
	ok.

truncate_yid() ->
	Sql = "truncate gp_high",
	% Sql = "DELETE FROM gp_high",
	lib_fun:query_sql(Sql).

code_detail(Code) ->
	{_Sum, List} = models_fun:get_sum_list(Code),
	YearsNum = find_years(List),

	% io:format("list:~p~n~n", [List]),
	L = models_fun:get_code_today_list(Code),
	% io:format("list:~p~n~n", [Today]),


	{_, OpenPrice} = lists:keyfind(<<"openPrice">>, 1, L),
	{_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
	{_, HighPrice} = lists:keyfind(<<"highPrice">>, 1, L),
	{_, LowerPrice} = lists:keyfind(<<"lowerPrice">>, 1, L),
	{_, Time} = lists:keyfind(<<"time">>, 1, L),
	{_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),

	{find_current_yid(List), OpenPrice, ClosePrice, HighPrice, LowerPrice, Time, StrTime, YearsNum}.	


find_years([]) ->
	0;
find_years(List) ->
	Years = lists:foldl(fun({Time, _, _}, ReplyList) -> 
		{{Year, _, _}, _} = lib_fun:timestamp_to_datetime(Time),
		case lists:member(Year, ReplyList) of
			true -> 
				ReplyList;
			_ ->
				[Year|ReplyList]
		end
	end, [], List),
	length(Years).

	% io:format("~p~n~p~n", [Years, length(Years)]),
	% ok.

	% io:format("~p~n", [List]).



%        {<<"openPrice">>,16.43},
%        {<<"closePrice">>,16.4},
%        {<<"highPrice">>,16.48},
%        {<<"lowerPrice">>,16.38},
%        {<<"time">>,1473782400},
%        {<<"str_time">>,<<"2016-09-14">>},




find_current_yid(List) when length(List) > 2 ->
	{_Time, _StrTime, ClosePrice} = get_last_pos(List),
	CutList = models_fun:cut_list(List),

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


