%% gen_server代码模板

-module(workboy_server).

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

-record(state, {}).

% --------------------------------------------------------------------
% External API
% --------------------------------------------------------------------
-export([do_work/2, do_work/3]).


do_work(Pid, Work) ->
    gen_server:cast(Pid, {work, Work}).

do_work(Pid, Key, Work) ->
    gen_server:cast(Pid, {work, Work, Key}).


% start_link() ->
%     gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

start_link() ->
    gen_server:start_link(?MODULE, [], []).


% --------------------------------------------------------------------
% Function: init/1
% Description: Initiates the server
% Returns: {ok, State}          |
%          {ok, State, Timeout} |
%          ignore               |
%          {stop, Reason}
% --------------------------------------------------------------------
init([]) ->
    {ok, #state{}}.

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
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.



% delete_page() ->
%     {Year, Jidu} = spider:today(),
%     Key = lib_fun:to_str(Year) ++ ":" ++ lib_fun:to_str(Jidu),
%     Sql = "delete from sina_web_page where info_key like '%"++ lib_fun:to_str(Key) ++"'",

%     io:format("~p~n~n", [Sql]),
%     mysql:query_sql(Sql).



insert_page(InfoKey, Link) ->
    Html = go:http_get(Link),
    Html1 = go:iconv(Html, 'gb2312', 'utf-8'),

    lib_fun:file_put_contents("/web/1.html", Html1),

    Data = [
        {<<"info_key">>, InfoKey},
        {<<"url">>, Link},
        {<<"html_page">>, Html1}
    ],

    mysql:insert("sina_web_page", Data),

    io:format("~p~n", [Link]).

% --------------------------------------------------------------------
% Function: handle_cast/2
% Description: Handling cast messages
% Returns: {noreply, State}          |
%          {noreply, State, Timeout} |
%          {stop, Reason, State}            (terminate/2 is called)
% --------------------------------------------------------------------
handle_cast({work, {init_data, _From}}, State) ->
    % delete_page(),
    % io:format("delete done!!~n~n"),
    Sql = "SELECT code,name FROM m_gp_list",
    Rows = mysql:get_assoc(Sql),
    Years = spider:years(),
    {TheYear, TheJiDu} = spider:today(),

    lists:foreach(fun(Row)->
        % timer:sleep(10),
        {_, Code} = lists:keyfind(<<"code">>, 1, Row),
        {_, Name} = lists:keyfind(<<"name">>, 1, Row),
        % io:format("")

        StrCode = lib_fun:to_str(Code),
        Code1 = string:sub_string(StrCode, 3, length(StrCode)),

        lists:foreach(fun({Year, Jidu}) ->
            InfoKey = lib_fun:to_str(Name) ++ ":" ++ lib_fun:to_str(Code) ++ ":" ++ lib_fun:to_str(Year) ++ ":" ++ lib_fun:to_str(Jidu),

            Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/"++lib_fun:to_str(Code1)++".phtml?year="++lib_fun:to_str(Year)++"&jidu="++lib_fun:to_str(Jidu),


            SqlKey = "SELECT id from sina_web_page where info_key = '"++lib_fun:to_str(InfoKey)++"' limit 1",
            % $row = $this->_mysql->get($sql);
            Res = mysql:get_assoc(SqlKey),

            case length(Res) =:= 0 of
                true ->
                    % io:format("~p~n", [{Link, Res}]);
                    insert_page(InfoKey, Link);
                _ ->
                    case  Year =:= TheYear andalso Jidu =:= TheJiDu of
                        true ->
                            io:format("link: ~p~n", [Link]);
                            % insert_page(InfoKey, Link);
                        _ ->
                            ok
                    end
            end



        end, Years)

        % Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/"++lib_fun:to_str(Code)++".phtml?year={$year}&jidu={$jd}",


    end, Rows),
    % Link = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/{$code1}.phtml?year={$year}&jidu={$jd}";



    table_work:delete(init_data),
    {stop, normal, State};
handle_cast({work, {fetch_web, From}}, State) ->
    Url = "https://www.baidu.com/",
    % case httpc:request(Url) of
    % case httpc:request(get, {Url, []}, [], []) of
    List = lists:seq(1,1000),
    lists:foreach(fun(X)->
        timer:sleep(10),
        case httpc:request(get, {Url, []},
                            [{autoredirect, true}, {timeout, 60000}, {version, "HTTP/1.1"}],
                            [{body_format, binary}]) of
            {ok, {_,_, _Body}}->
                From ! {from_workboy, "fetch success : " ++ Url ++ to_str(X)},
                ok;
            {error, Reason} ->
                From ! {from_workboy, "fetch failed !!!: " ++ Url},
                io:format("error cause ~p~n",[Reason])
        end
    end,List),

    From ! {from_workboy, "fetch done !!!"},

    table_work:delete(fetch_web),

    {stop, normal, State};

% +----------+----------+-----------+------------+-----------+------------+------------+------------+----------+--------------+
% | code     | high_yid | openPrice | closePrice | highPrice | lowerPrice | time       | str_time   | year_num | name         |
% +----------+----------+-----------+------------+-----------+------------+------------+------------+----------+--------------+
% | sh601099 |        1 |     4.710 |      4.620 |     4.720 |      4.620 | 1492099200 | 2017-04-14 |       11 | 太平洋       |
% | sz002154 |        1 |     4.670 |      4.620 |     4.670 |      4.600 | 1492099200 | 2017-04-14 |       11 | 报 喜 鸟     |
% | sz002263 |        2 |     3.590 |      3.560 |     3.600 |      3.550 | 1492099200 | 2017-04-14 |       10 | 大 东 南     |
% | sh600880 |        3 |     8.020 |      7.890 |     8.020 |      7.830 | 1492099200 | 2017-04-14 |       18 | 博瑞传播     |
% | sz002266 |        5 |     5.750 |      5.630 |     5.760 |      5.630 | 1492099200 | 2017-04-14 |       10 | 浙富控股     |
% | sz002140 |        5 |    14.350 |     13.940 |    14.480 |     13.900 | 1492099200 | 2017-04-14 |       11 | 东华科技     |
% | sh600467 |        5 |     4.150 |      4.090 |     4.150 |      4.080 | 1492099200 | 2017-04-14 |       14 | 好当家       |
% | sz002118 |        6 |     6.910 |      6.840 |     6.950 |      6.830 | 1492099200 | 2017-04-14 |       11 | 紫鑫药业     |
% | sz002081 |        6 |    11.090 |     10.860 |    11.140 |     10.810 | 1492099200 | 2017-04-14 |       12 | 金 螳 螂     |
% | sz002031 |        7 |     3.610 |      3.530 |     3.620 |      3.520 | 1492099200 | 2017-04-14 |       14 | 巨轮股份     |
% +----------+----------+-----------+------------+-----------+------------+------------+------------+----------+--------------+

handle_cast({work, {show_result, From}}, State) ->
    % Msg = "正在查看: code: ",
    % Msg1 = unicode:characters_to_binary(Msg),
    % From ! {from_workboy, Msg1},

    Sql = "SELECT A.code,
            A.high_yid as yid,
            A.closePrice as price,
            A.str_time as date,
            A.year_num,
            B.name
            from gp_high as A
            inner join m_gp_list as B
            on A.code = B.code
            where
            A.year_num >= 10
            order by A.high_yid asc
            limit 50
            ",
    List = mysql:get_assoc(Sql),
    lists:foldr(fun(L, ReplyList) ->
        {_, Code} = lists:keyfind(<<"code">>, 1, L),
        {_, Name} = lists:keyfind(<<"name">>, 1, L),
        {_, StrTime} = lists:keyfind(<<"date">>, 1, L),
        {_, HighYid} = lists:keyfind(<<"yid">>, 1, L),
        {_, ClosePrice} = lists:keyfind(<<"price">>, 1, L),

        % SumPrice1 = SumPrice + ClosePrice,
        % {SumPrice1, [{Time, StrTime, ClosePrice}|ReplyList]}

        % Utf8Name = unicode:characters_to_binary(to_str(Name)),

        Msg = "code:"++to_str(Code)++" name:"++to_str(Name) ++ "time:"++to_str(StrTime) ++ "yid:"++to_str(HighYid) ++ "price:"++to_str(ClosePrice),
        % Msg = "code:"++to_str(Code)++", time:"++to_str(StrTime) ++ ", yid:"++to_str(HighYid) ++ ", price:"++to_str(ClosePrice),
        % io:format("MSG:~p~n~p~n~p~n~p~n~p~n~n", [Code, Utf8Name, StrTime, HighYid, ClosePrice]),
        io:format("msg:~p~n", [Msg]),

        Link = "/page/?a=detail&code="++to_str(Code),
        L1 = [{<<"url">>, lib_fun:to_binary(Link)}|L],

        Msg0 = jsx:encode(L1),
        Msg1 = unicode:characters_to_binary(Msg0),
        From ! {from_workboy, Msg1},
        % Str = "<a href=\"/page/?a=chart&code="+to_str(Code)+"\">"++Name++"</a>",
        % Str1 = unicode:characters_to_binary(Str),
        % From ! {from_workboy, unicode:characters_to_binary(Name)},
        % From ! {from_workboy, Str1},



        ReplyList
    end, [], List),



    table_work:delete(show_result),

    {stop, normal, State};
handle_cast({work, {find_yid, From}}, State) ->
    io:format("do work here ~n"),
    % do work here

    CodeList = find_yid:get_code(),

    Sql = "INSERT INTO gp_high(code, high_yid, openPrice, closePrice, highPrice, lowerPrice, time, str_time, year_num) VALUES ",

    Sql1 = lists:foldl(fun(CodeL, ReplySql) ->
        timer:sleep(10),

        {_, Code} = lists:keyfind(<<"code">>, 1, CodeL),
        % {_, Name} = lists:keyfind(<<"name">>, 1, CodeL),
        % _Reply = find_yid:code(Code),

        {YId, OpenPrice, ClosePrice, HighPrice, LowerPrice, Time, StrTime, YearsNum} = find_yid:code(Code),

        Msg = "正在分析: code: " ++ to_str(Code),
        Msg1 = unicode:characters_to_binary(Msg),
        From ! {from_workboy, Msg1},

        ReplySql ++ "('"++to_str(Code)++"', "++to_str(YId)++", "
            ++to_str(OpenPrice)++", "++to_str(ClosePrice)++", "
            ++to_str(HighPrice)++", "++to_str(LowerPrice)++", "
            ++to_str(Time)++", '"++to_str(StrTime)++"', "
            ++to_str(YearsNum)++"),"

    end, Sql, CodeList),

    Sql2 = rtrim(Sql1, ","),

    % truncate_yid(),
    % Sql = "truncate gp_high",
    % Sql = "DELETE FROM gp_high",
    mysql:query_sql("truncate gp_high"),

    % io:format("~p~n", [Sql2]),
    mysql:query_sql(Sql2),

    From ! {from_workboy, "parse done !!!"},

    table_work:delete(find_yid),

    {stop, normal, State};
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

to_str(X) when is_list(X) -> X;
to_str(X) when is_atom(X) -> atom_to_list(X);
to_str(X) when is_binary(X) -> binary_to_list(X);
to_str(X) when is_integer(X) -> integer_to_list(X);
to_str(X) when is_float(X) -> float_to_list(X).

trim(Str) ->
    string:strip(Str).

% ltrim(Str) ->
%     string:strip(Str, left).

% rtrim(Str) ->
%     string:strip(Str, right).

% trim(Str, SubStr) ->
%     LStr = ltrim(Str, SubStr),
%     rtrim(LStr, SubStr).

rtrim(Str, SubStr) ->
    NewStr = trim(Str),
    NewSubStr = trim(SubStr),
    LengthNewStr = string:len(NewStr),
    case string:len(NewSubStr) of
        LengthNewSubStr when LengthNewSubStr == 0 ->
            NewStr;
        LengthNewSubStr ->
            case LengthNewStr - LengthNewSubStr of
                Length when Length < 0 ->
                    NewStr;
                Length ->
                    Head = string:substr(NewStr, Length + 1, LengthNewSubStr),
                    case string:equal(Head, NewSubStr) of
                        true ->
                            Tail = string:substr(NewStr, 1, Length),
                            rtrim(Tail, SubStr);
                        false ->
                            NewStr
                    end
            end
    end.

% ltrim(Str, SubStr) ->
%     NewStr = trim(Str),
%     NewSubStr = trim(SubStr),
%     LengthNewStr = string:len(NewStr),
%     case string:len(NewSubStr) of
%         LengthNewSubStr when LengthNewSubStr == 0 ->
%             NewStr;
%         LengthNewSubStr ->
%             case LengthNewStr - LengthNewSubStr of
%                 Length when Length < 0 ->
%                     NewStr;
%                 Length ->
%                     Head = string:substr(NewStr, 1, LengthNewSubStr),
%                     case string:equal(Head, NewSubStr) of
%                         true ->
%                             Tail = string:substr(NewStr, LengthNewSubStr+1, Length),
%                             ltrim(Tail, SubStr);
%                         false ->
%                             NewStr
%                     end
%             end
%     end.

