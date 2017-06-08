%%%-------------------------------------------------------------------
%% @doc mysql public API
%% @end
%%%-------------------------------------------------------------------

-module(workboy).
-compile(export_all).
% -export([start/1, start/2]).

%% 启动不能同时运行的任务
start(Work) ->
    % io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, NewWork]),
    {Key, From} = Work,

    case table_work:select(Key) of
        [] ->
            _ = case workboy_sup:start_child() of
                {ok, Pid} ->
                    % NewWork = #{key=> Key, pid=>Pid, work=>Work},
                    table_work:add(Key, Work),
                    do_work(Pid, Work);
                _ ->
                    {error, "can't start a work process"}
            end;
        _ ->
            From ! {from_workboy, "already add task...================================================="},
            % From ! {from_workboy, <<"请不要重复添加...=================================================">>},

            ok
    end,

    % io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, Reply]),

    ok.



%% 可以同时运行多个
% start(Work) ->
%     case workboy_sup:start_child() of
%         {ok, Pid} ->
%             do_work(Pid, Work);
%         _ ->
%             {error, "can't start a work process"}
%     end.

do_work(Pid, Work) ->
    workboy_server:do_work(Pid, Work).

