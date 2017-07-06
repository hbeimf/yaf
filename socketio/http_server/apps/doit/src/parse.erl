-module(parse).
-compile(export_all).


% parse:go().





parse_list([], _) ->
    {error, "empty list"};
parse_list(List, Add) ->
    L1 = lists:keysort(2, List),

    [{_, First}|_] = L1,
    {_, Last} = lists:last(L1),

    Cut = cut(First, Last, Add),

    cut_list(Cut, List).

    % io:format("list==================~n~p~n", [{First, Last}]),

    % io:format("cut==================~n~p~n", [{Cut, cut_list(Cut, List)}]),


    % ok.


cut_list(Cut, List) ->
    lists:foldl(fun({N, Start, End}, Res) ->
        [{N, Start, End, get_num(Start, End, List)}|Res]
    end, [], Cut).

get_num(Start, End, List) ->
    lists:foldl(fun({_, P}, N) ->
        case P >= Start andalso P < End of
            true ->
                N + 1;
            _ ->
                N
        end
    end, 0, List).




cut(Start, End, Add) ->
    cut(Start, End, 1, [], Add).

cut(Start, End, N, Reply, Add) ->
    case Start < End of
        true ->
            Start1 = Start + Start * Add,
            cut(Start1, End, N+1, [{N, three(Start), three(Start1)}|Reply], Add);
        _ ->
            Reply
    end.

% 精确到小数点后3位
three(Num) ->
    list_to_float(hd(io_lib:format("~.3f",[Num]))).


%  ==============================================================================
go() ->
    Sql = "SELECT code,name FROM m_gp_list where code = 'sh600011'",
    Rows = mysql:get_assoc(Sql),
    lists:foreach(fun(Row) ->
        {_, Code} = lists:keyfind(<<"code">>, 1, Row),
        List = get_list_by_code(Code),
        % timer:sleep(100),

        % Reply = go:parse_list(List),
        _Reply = parse_list(List, 0.02),
        ok

        % io:format("list==================~n~p~p~n", [Code, Reply])


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


