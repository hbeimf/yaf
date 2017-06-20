%% gen_server代码模板
% 遍历股票列表，
% 将所有的历史链接都检查是否己下载过，
% 如没下载则下载相应的页面提取数据，
% 如已下载则忽略，
% 如果是当季度链接，则也要下载提取数据


-module(doit_fetch_web).

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
-export([doit/1]).

doit(FromPid) ->
    gen_server:cast(?MODULE, {doit, FromPid}).



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
handle_cast({doit, FromPid}, State) ->
    io:format("doit  !! ============== ~n~n"),

    % lists:foreach(fun(_I) ->
    %     timer:sleep(10),
    %     FromPid ! {from_doit, <<"haha">>}
    % end, lists:seq(1, 1000)),


    Sql = "SELECT code,name FROM m_gp_list",
    Rows = mysql:get_assoc(Sql),
    Years = link:years(),
    {TheYear, TheJiDu} = link:today(),

    lists:foreach(fun(Row)->
        % timer:sleep(10),
        {_, Code} = lists:keyfind(<<"code">>, 1, Row),
        % {_, Name} = lists:keyfind(<<"name">>, 1, Row),
        % io:format("")

        StrCode = go_lib:to_str(Code),
        Code1 = string:sub_string(StrCode, 3, length(StrCode)),

        lists:foreach(fun({Year, Jidu}) ->
            % InfoKey = go_lib:to_str(Name) ++ ":" ++ go_lib:to_str(Code) ++ ":" ++ go_lib:to_str(Year) ++ ":" ++ go_lib:to_str(Jidu),

            Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/"++go_lib:to_str(Code1)++".phtml?year="++go_lib:to_str(Year)++"&jidu="++go_lib:to_str(Jidu),

            % io:format("link: ~p~n", [Link]),

            % SqlKey = "SELECT id from sina_web_page where info_key = '"++go_lib:to_str(InfoKey)++"' limit 1",
            SqlKey = "SELECT id from sina_web_page where url = '"++go_lib:to_str(Link)++"' limit 1",


            % $row = $this->_mysql->get($sql);
            Res = mysql:get_assoc(SqlKey),

            case length(Res) =:= 0 of
                true ->
                    % io:format("~p~n", [{Link, Res}]);
                    % insert_page(InfoKey, Link);
                    Data = [{"url", Link}],
                    mysql:insert("sina_web_page", Data),
                    FromPid ! {from_doit, Link},
                    link:link(Code, Link);
                _ ->
                    case  Year =:= TheYear andalso Jidu =:= TheJiDu of
                        true ->
                            % io:format("++++++++++++++++++++++++++++++++++link: ~p~n", [Link]);
                            % insert_page(InfoKey, Link);
                            FromPid ! {from_doit, Link},
                            link:link(Code, Link);
                        _ ->
                            ok
                    end
            end



        end, Years)

        % Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/"++go_lib:to_str(Code)++".phtml?year={$year}&jidu={$jd}",


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

% insert_page(InfoKey, Link) ->
%     Html = go:http_get(Link),
%     Html1 = go:iconv(Html, 'gb2312', 'utf-8'),

%     % go_lib:file_put_contents("/web/1.html", Html1),

%     Data = [
%         {<<"info_key">>, InfoKey},
%         {<<"url">>, Link},
%         {<<"html_page">>, Html1}
%     ],

%     mysql:insert("sina_web_page", Data),

%     io:format("~p~n", [Link]).


