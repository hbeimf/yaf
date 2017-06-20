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
handle_cast(doit, State) ->
    io:format("doit  !! ============== ~n~n"),

    %% 此处将结果json缓存到数据库中，
    Sql = "SELECT code,name FROM m_gp_list limit 3",
    Rows = mysql:get_assoc(Sql),
    lists:foreach(fun(Row) ->
        {_, Code} = lists:keyfind(<<"code">>, 1, Row),
        List = get_list_by_code(Code),

        io:format("list==================~n~p~n", [List])


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

get_list_by_code(Code) ->
    Sql = "select time, closePrice from gp_history where code = '" ++ go_lib:to_str(Code) ++ "'",
    List = mysql:get_assoc(Sql),
    get_list_by_code_tolist(List).
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
    % Sql = "select time, closePrice from gp_history where code = '" ++ go_lib:to_str(Code) ++ "'",
    % List = mysql:get_assoc(Sql),
    lists:foldl(fun(L, {ReplyList, ShowList}) ->
        {_, Time} = lists:keyfind(<<"time">>, 1, L),
        {_, ClosePrice} = lists:keyfind(<<"closePrice">>, 1, L),

        {{Y, M, D}, _} = go_lib:timestamp_to_datetime(Time),
        Date = go_lib:to_str(Y)++"-"++go_lib:to_str(M)++"-"++go_lib:to_str(D),

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
