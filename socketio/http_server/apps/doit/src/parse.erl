-module(parse).
-compile(export_all).


% parse:go().





parse_list([]) ->
    {error, "empty list"};
parse_list(List) ->

    ok.





%  ==============================================================================
go() ->
    Sql = "SELECT code,name FROM m_gp_list where code = 'sh600011'",
    Rows = mysql:get_assoc(Sql),
    lists:foreach(fun(Row) ->
        {_, Code} = lists:keyfind(<<"code">>, 1, Row),
        List = get_list_by_code(Code),
        % timer:sleep(100),

        % Reply = go:parse_list(List),
        Reply = parse_list(List),

        io:format("list==================~n~p~p~n", [Code, Reply])


    end, Rows),
    ok.



get_list_by_code(Code) ->
    Sql = "select time, closePrice from gp_history where code = '" ++ go_lib:to_str(Code) ++ "'",
    List = mysql:get_assoc(Sql),
    get_list_by_code_tolist(List).


get_list_by_code_tolist(List) ->
    lists:foldl(fun(L, ReplyList) ->
        {_, Time} = lists:keyfind(<<"time">>, 1, L),
        {_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),
        [{Time, ClosePrice}|ReplyList]
    end, [], List).


