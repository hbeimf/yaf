-module(table_work).
-compile(export_all).

-include_lib("stdlib/include/qlc.hrl").
%% 定义记录结构
-include("table.hrl").



-define(TABLE, work).
% -define(RECORDNAME, work).


%%== 查询 =============================================================

do(Q) ->
    F = fun() -> qlc:e(Q) end,
    {atomic,Val} = mnesia:transaction(F),
    Val.

%% SELECT * FROM shop
%% 选取所有列
select() ->
    do(qlc:q([X || X <- mnesia:table(?TABLE)])).

%% SELECT * FROM shop WHERE shop.quantity < 250
%% 选取指定条件的数据
select(Key) ->
    do(qlc:q([X || X <- mnesia:table(?TABLE),
                X#?TABLE.key =:= Key
            ])).

% select_friend(SceneId, Pid) ->
%     do(qlc:q([X || X <- mnesia:table(?TABLE),
%                 X#scene.scene_id =:= SceneId,
%                 X#scene.pid =/= Pid
%             ])).

%% == 数据操作 ===============================================

%% 增加一行
add(Key, Work) ->
    Row = #?TABLE{key = Key, work = Work},
    F = fun() ->
            mnesia:write(Row)
    end,
    mnesia:transaction(F).

%% 删除一行
delete(Key) ->
    Oid = {?TABLE, Key},
    F = fun() ->
            mnesia:delete(Oid)
    end,
    mnesia:transaction(F).
