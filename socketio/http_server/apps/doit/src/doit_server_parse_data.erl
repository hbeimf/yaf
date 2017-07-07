%% gen_server代码模板

-module(doit_server_parse_data).

-behaviour(gen_server).
% --------------------------------------------------------------------
% Include files
% --------------------------------------------------------------------

% --------------------------------------------------------------------
% External exports
% --------------------------------------------------------------------
-export([]).

% gen_server callbacks
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% -record(state, {}).

% --------------------------------------------------------------------
% External API
% --------------------------------------------------------------------
-export([doit/0]).

doit() ->
    gen_server:cast(?MODULE, doit).



% -export([start_goroutine/0, info/0, stop_goroutine/1, send_cast/2]).

% info() ->
%     gen_server:call(?MODULE, info).

% start_goroutine() ->
%     gen_server:call(?MODULE, start_goroutine).

% stop_goroutine(GoMBox) ->
%     gen_server:call(?MODULE, {stop_goroutine, GoMBox}).

% send_cast(GoMBox, Msg) ->
%     gen_server:cast(?MODULE, {send_cast, GoMBox, Msg}).

% get_gombox() ->
%     gen_server:call(?MODULE, get_gombox).

% start_link() ->
%     gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


% --------------------------------------------------------------------
% Function: init/1
% Description: Initiates the server
% Returns: {ok, State}          |
%          {ok, State, Timeout} |
%          ignore               |
%          {stop, Reason}
% --------------------------------------------------------------------
init([]) ->
    {ok, []}.

% --------------------------------------------------------------------
% Function: handle_call/3
% Description: Handling call messages
% Returns: {reply, Reply, State}          |
%          {reply, Reply, State, Timeout} |
%          {noreply, State}               |
%          {noreply, State, Timeout}      |
%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------

% handle_call({doit, FromPid}, _From, State) ->
%     io:format("doit  !! ============== ~n~n"),

%     lists:foreach(fun(_I) ->
%         FromPid ! {from_doit, <<"haha">>}
%     end, lists:seq(1, 100)),

%     {reply, [], State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

% --------------------------------------------------------------------
% Function: handle_cast/2
% Description: Handling cast messages
% Returns: {noreply, State}          |
%          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
% handle_cast({send_cast, GoMBox, Msg}, State) ->
%     io:format("send cast !! ============== ~n~n"),
%     % {ok, GoMBox} = application:get_env(go, go_mailbox),
%     % io:format("message ~p!! ============== ~n~n", [GoMBox]),
%     gen_server:cast(GoMBox, {Msg, self()}),
%     {noreply, State};
% doit_server_parse_data:doit().
% sh600011
handle_cast(doit, State) ->
    io:format("doit  !! ============== ~n~n"),

    %% 此处将结果json缓存到数据库中，
    % Sql = "SELECT code,name FROM m_gp_list where code = 'sh600011'",
    Sql = "SELECT code,name FROM m_gp_list",

    Rows = mysql:get_assoc(Sql),
    lists:foreach(fun(Row) ->
        {_, Code} = lists:keyfind(<<"code">>, 1, Row),
        List = get_list_by_code(Code),
        % timer:sleep(100),

        case List of
            [] ->
                % Reply = [],
                ok;
            _ ->
                % Reply = jsx:encode([go:parse_list(List)])
                to_json(go:parse_list(List), Code)

        end

        % Reply1 = parse:parse_list(List, 0.05),

        % io:format("list==================~n~p~p~n", [Code, Reply])


    end, Rows),


    {noreply, State};
handle_cast(_Msg, State) ->
    {noreply, State}.

% --------------------------------------------------------------------
% Function: handle_info/2
% Description: Handling all non call/cast messages
% Returns: {noreply, State}          |
%          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
handle_info(_Info, State) ->
    {noreply, State}.

% handle_info(Info, State) ->
%     % 接收来自go 发过来的异步消息
%     io:format("~nhandle info BBB!!============== ~n~p~n", [Info]),
%     {noreply, State}.

% --------------------------------------------------------------------
% Function: terminate/2
% Description: Shutdown the server
% Returns: any (ignored by gen_server)
% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

% --------------------------------------------------------------------
% Func: code_change/3
% Purpose: Convert process state when code is changed
% Returns: {ok, NewState}
% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


% private functions

% doit_server_parse_data:doit().
to_json(Tuple, Code) ->
    {{Time, Price, Yid},
        L1, L2} = Tuple,

    L22 = lists:foldl(fun({Y, L}, ReplyList) ->
        TL = [
            {<<"year">>, Y},
            {<<"child">>, to_kv_list(L)}
        ],
        [TL|ReplyList]
        % io:format("~p~n", [L])
    end, [], L2),


    L = [
        {<<"time">>, Time},
        {<<"price">>, Price},
        {<<"yid">>, Yid},
        {<<"all">>, to_kv_list(L1)},
        {<<"detail">>, L22}
    ],

    Json = jsx:encode(L),
    io:format("list==================~n~p~n", [{Code, Json}]),

    ok.

to_kv_list(List) ->
    lists:foldl(fun({Y, Start, End, Num}, ReplyList) ->
        TupleList = [
            {<<"yid">>, Y},
            {<<"start">>, Start},
            {<<"end">>, End},
            {<<"num">>, Num}
        ],
        [TupleList|ReplyList]
    end, [], List).



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
