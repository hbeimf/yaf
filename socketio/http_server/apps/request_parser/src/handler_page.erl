%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(handler_page).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-include_lib("kernel/include/file.hrl").


init(_Type, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {Action, Req2} = cowboy_req:qs_val(<<"a">>, Req),
    {ok, Req3} = action(Action, Req2),
    {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
    ok.

% % http://www.xxxx.com:8080/page/?a=chart4
% action(<<"chart4">>, Req) ->
%     Body = tpl:compile("chart4.dtl", [], chart4),
%     cowboy_req:reply(200, [
%         {<<"content-type">>, <<"text/html">>}
%     ], Body, Req);


% % http://www.xxxx.com:8080/page/?a=chart3
% action(<<"chart3">>, Req) ->
%     Body = tpl:compile("chart3.dtl", [], chart3),
%     cowboy_req:reply(200, [
%         {<<"content-type">>, <<"text/html">>}
%     ], Body, Req);

% % http://www.xxxx.com:8080/page/?a=chart2
% action(<<"chart2">>, Req) ->
%     Body = tpl:compile("chart2.dtl", [], chart2),
%     cowboy_req:reply(200, [
%         {<<"content-type">>, <<"text/html">>}
%     ], Body, Req);
% % http://www.xxxx.com:8080/page/?a=chart1
% action(<<"chart1">>, Req) ->
%     Body = tpl:compile("chart1.dtl", [], chart1),
%     cowboy_req:reply(200, [
%         {<<"content-type">>, <<"text/html">>}
%     ], Body, Req);

action(<<"tpl">>, Req) ->
    Data = go:call_list(),
    % pre_data(Data),

    Body = tpl:compile("tpl.dtl", pre_data(Data), chart),
    cowboy_req:reply(200, [
        {<<"content-type">>, <<"text/html">>}
    ], Body, Req);

% http://www.xxxx.com:8080/page/?a=chart
action(<<"chart">>, Req) ->
    Body = tpl:compile("chart.dtl", [], chart),
    cowboy_req:reply(200, [
        {<<"content-type">>, <<"text/html">>}
    ], Body, Req);
% http://www.xxxx.com:8080/page/?a=chart
action(<<"detail">>, Req) ->
    {Code, Req2} = cowboy_req:qs_val(<<"code">>, Req),
    List = get_list_by_code(Code),
    % io:format("~p~n", [List]),

    {L1, L2} = get_list_by_code_tolist(List),

    List1 = go:parse_list(L1, 0.1),
    % io:format("~p~n", [List1]),
    PList = pre_data(List1),
    % io:format("~p~n", [PList]),

    Data = [{<<"code">>, lib_fun:to_binary(Code)}|PList],

    Data1 = [{<<"data">>, lists:reverse(L2)}|Data],

    Data2 = [{<<"name">>, get_name(Code)}|Data1],

    Body = tpl:compile("detail.dtl", Data2, detail),
    cowboy_req:reply(200, [
        {<<"content-type">>, <<"text/html">>}
    ], Body, Req);


    % Body = tpl:compile("datail.dtl", [], detail),

    % cowboy_req:reply(200, [
    %     {<<"content-type">>, <<"text/html">>}
    % ], Body, Req);

% http://www.xxxx.com:8080/page/?a=proto
action(<<"proto">>, Req) ->
    Dir = code:lib_dir(request_parser, priv) ++ "/protocol.proto",
    error_logger:info_msg("dir XXX  ~p~n", [Dir]),

    {_, Info} = file:read_file_info(Dir, [{time, universal}]),

    Body = case file_get_contents(Dir) of
        {ok, Bin} ->
            Bin;
        {error, _Msg} ->
            <<"hello world!!">>
    end,

    Date = cowboy_clock:rfc1123(Info#file_info.mtime),
    cowboy_req:reply(200, [
        {<<"last-modified">>, Date},
        {<<"content-type">>, <<"text/plain">>}
    ], Body, Req);
action(undefined, Req) ->
    cowboy_req:reply(400, [], <<"Missing a parameter.">>, Req);
action(_, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).


file_get_contents(Dir) ->
    case file:read_file(Dir) of
        {ok, Bin} ->
            {ok, Bin};
        {error, Msg} ->
            {error, Msg}
    end.

pre_data({{Time, CP, Yid}, List, CList}) ->
    CList1 = lists:foldr(fun({Year, L}, Res) ->
        L1 = pre_list(L),
        [[{<<"year">>, Year}, {<<"l">>, L1}]|Res]
    end, [], lists:keysort(1, CList)),

    [
        {<<"time">>, Time},
        {<<"p">>, CP},
        {<<"yid">>, Yid},
        {<<"list">>, pre_list(List)},
        {<<"clist">>, CList1}
    ].

pre_list(List) ->
    lists:foldr(fun({Y, Start, End, Num}, Res) ->
        [[{<<"y">>, Y}, {<<"start">>, Start}, {<<"end">>, End}, {<<"num">>, Num}]|Res]
    end, [], List).

% get_list_by_code(Code) ->
%     Sql = "select time, closePrice from gp_history where code = '" ++ lib_fun:to_str(Code) ++ "'",
%     List = mysql:get_assoc(Sql),
%     lists:foldl(fun(L, ReplyList) -> 
%         {_, Time} = lists:keyfind(<<"time">>, 1, L),
%         {_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
%         [{Time, ClosePrice}|ReplyList]
%         % {_, OpenPrice} = lists:keyfind(<<"openPrice">>, 1, L),
%         % {_, HighPrice} = lists:keyfind(<<"highPrice">>, 1, L),
%         % {_, LowerPrice} = lists:keyfind(<<"lowerPrice">>, 1, L),
%         % {_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),
%         % SumPrice1 = SumPrice + ClosePrice,
%         % {SumPrice1, [{Time, StrTime, OpenPrice, ClosePrice, HighPrice, LowerPrice}|ReplyList]}
%     end, [], List).

get_list_by_code(Code) ->
    Sql = "select time, closePrice from gp_history where code = '" ++ lib_fun:to_str(Code) ++ "'",
    List = mysql:get_assoc(Sql),
    List.
    % lists:foldl(fun(L, ReplyList) -> 
    %     {_, Time} = lists:keyfind(<<"time">>, 1, L),
    %     {_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
    %     [{Time, ClosePrice}|ReplyList]
    %     % {_, OpenPrice} = lists:keyfind(<<"openPrice">>, 1, L),
    %     % {_, HighPrice} = lists:keyfind(<<"highPrice">>, 1, L),
    %     % {_, LowerPrice} = lists:keyfind(<<"lowerPrice">>, 1, L),
    %     % {_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),
    %     % SumPrice1 = SumPrice + ClosePrice,
    %     % {SumPrice1, [{Time, StrTime, OpenPrice, ClosePrice, HighPrice, LowerPrice}|ReplyList]}
    % end, [], List).



get_list_by_code_tolist(List) ->
    % Sql = "select time, closePrice from gp_history where code = '" ++ lib_fun:to_str(Code) ++ "'",
    % List = mysql:get_assoc(Sql),
    lists:foldl(fun(L, {ReplyList, ShowList}) -> 
        {_, Time} = lists:keyfind(<<"time">>, 1, L),
        {_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),

        {{Y, M, D}, _} = lib_fun:timestamp_to_datetime(Time),
        Date = lib_fun:to_str(Y)++"-"++lib_fun:to_str(M)++"-"++lib_fun:to_str(D),

        {[{Time, ClosePrice}|ReplyList], 
            [[{<<"time">>, Date}, {<<"closePrice">>, ClosePrice}]|ShowList]
        }

        % {_, OpenPrice} = lists:keyfind(<<"openPrice">>, 1, L),
        % {_, HighPrice} = lists:keyfind(<<"highPrice">>, 1, L),
        % {_, LowerPrice} = lists:keyfind(<<"lowerPrice">>, 1, L),
        % {_, StrTime} = lists:keyfind(<<"str_time">>, 1, L),
        % SumPrice1 = SumPrice + ClosePrice,
        % {SumPrice1, [{Time, StrTime, OpenPrice, ClosePrice, HighPrice, LowerPrice}|ReplyList]}
    end, {[], []}, List).




get_name(Code) ->
    Sql = "select * from m_gp_list where code = '"++lib_fun:to_str(Code)++"' limit 1",
    [Row] = mysql:get_assoc(Sql),
    {_, Name} = lists:keyfind(<<"name">>, 1, Row),
    Name.










