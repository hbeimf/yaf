%% gen_server代码模板

-module(doit_server_add_status).

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
-export([doit/2]).

doit(Code, Data) ->
    gen_server:cast(?MODULE, {doit, Code, Data}).



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
    % _TRef = erlang:send_after(100, self(), update),
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
handle_cast({doit, Code, Data}, _State) ->
    % io:format("doit  !! ============== ~n~p~n~n", [{Code, DataTuple}]),
    % Status = #{
    %     code => Code,
    %     last_time => Time,
    %     last_price => Price,
    %     last_yid => Yid,
    %     all_years => length(L2)
    % },
    Code = maps:get(code, Data),
    LastTime = maps:get(last_time, Data),
    LastPrice = three(maps:get(last_price, Data)),
    LastYid = maps:get(last_yid, Data),
    AllYears = maps:get(all_years, Data),

    Sql = "REPLACE INTO parse_status(code, last_time, last_price, last_yid, all_years) VALUES "
             ++  "('"++go_lib:to_str(Code)++"', "++go_lib:to_str(LastTime)++", "++go_lib:to_str(LastPrice)++", "
                ++go_lib:to_str(LastYid)++", "++go_lib:to_str(AllYears)++")",


    % Sql2 = go:rtrim(Sql1, ","),

    io:format("~n=======================~n ~p~n~n", [{LastPrice, Sql}]),
    mysql:query_sql(Sql),

    {noreply, []};
handle_cast(_Msg, State) ->
    {noreply, State}.

% --------------------------------------------------------------------
% Function: handle_info/2
% Description: Handling all non call/cast messages
% Returns: {noreply, State}           %          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
handle_info(update, _State) ->
    % io:format("update  ================== ~n~p~n", [State]),

    % DROP INDEX IDX_code_time ON gp_history;
    % CREATE UNIQUE INDEX IDX_code_time ON gp_history(code, str_time);

    % 每一秒钟将数据写入数据库，减轻关系数据库的压力
    % case length(State) > 0 of
    %     true ->
    %         Sql = "REPLACE INTO parse_json(code, data) VALUES ",
    %         Sql1 = lists:foldl(fun({Code, Data}, ReplySql) ->
    %             ReplySql ++ "('"++go_lib:to_str(Code)++"', '"++go_lib:to_str(Data)++"'),"
    %         end, Sql, State),
    %         Sql2 = go:rtrim(Sql1, ","),
    %         io:format("~n=======================~n ~p~n~n", [Sql2]),
    %         mysql:query_sql(Sql2),

    %         ok;
    %     _ ->
    %         ok
    % end,

    % _TRef = erlang:send_after(100, self(), update),
    {noreply, []};
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

three(Num) ->
    hd(io_lib:format("~.3f",[Num])).
