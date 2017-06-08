%%%-------------------------------------------------------------------
%% @doc mysql public API
%% @end
%%%-------------------------------------------------------------------

-module(mysql).
-compile(export_all).
% -include("config.hrl").

%% lib_emysql

get_assoc(Sql) ->
    get_assoc(default, Sql).

get_assoc(Pool, Sql) ->
    {_, _, Field, Data, _} = query_sql(Pool, Sql),
    FieldList = lists:map(fun({_F1, _F2, _F3, _F4, _F5, _F6, FieldName, _F8, _F9, _F10, _F11, _F12, _F13, _F14, _F15}) ->
                                FieldName
                            end, Field),
    DataList = lists:map(fun(L) ->
                            lists:zip(FieldList, L)
                         end, Data),
    DataList.

update(TableName, List, Where) ->
    update(default, TableName, List, Where).

update(Pool, TableName, List, Where) ->
    query_sql(Pool, update_sql(TableName, List, Where)).

update_sql(TableName, List, Where) ->
    SetList = lists:map(fun({Key, Val}) ->
                lists:concat(["`", lib_fun:to_str(Key), "` = '", go:str_replace(lib_fun:to_str(Val), "'", "\\'"), "'"])
    end, List),
    Set = string:join(SetList, ", "),
    lists:concat(["UPDATE `", TableName, "`", " SET ", Set, " WHERE ", Where]).


insert(TableName, List) ->
    insert(default, TableName, List).

insert(Pool, TableName, List) ->
    query_sql(Pool, insert_sql(TableName, List)).

insert_sql(TableName, List) ->
    {FieldList, DataList} = lists:unzip(List),

    FilterFieldList = lists:map(fun(Key) ->
        lib_fun:to_str(Key)
    end, FieldList),
    FieldStr = string:join(FilterFieldList, "`, `"),
    DataList1 = lists:map(fun(F) ->
        FF = go:str_replace(lib_fun:to_str(F), "'", "\\'"),
        lists:concat(["'", FF, "'"])
    end, DataList),
    DataStr = string:join(DataList1, ", "),
    lists:concat(["INSERT INTO `", TableName, "` (`", FieldStr, "`) VALUES (", DataStr, ")"]).

query_sql(Sql) ->
    query_sql(default, Sql).

% query_sql(Pool, Sql) ->
%     emysql:execute(Pool, lib_fun:to_binary(Sql)).

query_sql(Pool, Sql) ->
    try
        emysql:execute(Pool, lib_fun:to_binary(Sql))
    catch
         Class:Reason ->
            lager:error(
                "~nStacktrace:~s",
                [lager:pr_stacktrace(erlang:get_stacktrace(), {Class, Reason})]),

            init_emysql(),
            emysql:execute(Pool, lib_fun:to_binary(Sql))
    end.

% init_emysql() ->
%     emysql:add_pool(?DB, ?POOL_SIZE, ?DB_USER_NAME, ?DB_PASSWORD, ?DB_HOST, ?DB_PORT, ?DB_NAME, ?DB_ENCODE).


init_emysql() ->
    lager:info("connect mysql !!"),
    {ok, Pools} = application:get_env(mysql, pools),
    lists:foreach(fun({Pool, ConfigList}) ->
        {host, Host} = lists:keyfind(host, 1, ConfigList),
        {port, Port} = lists:keyfind(port, 1, ConfigList),
        {user_name, UserName} = lists:keyfind(user_name, 1, ConfigList),
        {password, Password} = lists:keyfind(password, 1, ConfigList),
        {database_name, DatabaseName} = lists:keyfind(database_name, 1, ConfigList),
        {encode, Encode} = lists:keyfind(encode, 1, ConfigList),
        {pool_size, PoolSize} = lists:keyfind(pool_size, 1, ConfigList),
        emysql:add_pool(Pool, PoolSize, UserName, Password, Host, Port, DatabaseName, Encode)
    end, Pools).

