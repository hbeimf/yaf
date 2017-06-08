-module(table_scene).
-compile(export_all).

-include_lib("stdlib/include/qlc.hrl").
%% 定义记录结构
-include("table.hrl").

%%== 查询 =============================================================

do(Q) ->
    F = fun() -> qlc:e(Q) end,
    {atomic,Val} = mnesia:transaction(F),
    Val.

%% SELECT * FROM shop
%% 选取所有列
select() ->
    do(qlc:q([X || X <- mnesia:table(scene)])).

%% SELECT * FROM shop WHERE shop.quantity < 250
%% 选取指定条件的数据
select(SceneId) ->
    do(qlc:q([X || X <- mnesia:table(scene),
                X#scene.scene_id =:= SceneId
            ])).

select_friend(SceneId, Pid) ->
	do(qlc:q([X || X <- mnesia:table(scene),
                X#scene.scene_id =:= SceneId,
                X#scene.pid =/= Pid
            ])).

%% == 数据操作 ===============================================

%% 增加一行
add(Pid, SceneId) ->
    Row = #scene{pid = Pid, scene_id = SceneId},
    F = fun() ->
            mnesia:write(Row)
    end,
    mnesia:transaction(F).

%% 删除一行
delete(Pid) ->
    Oid = {scene, Pid},
    F = fun() ->
            mnesia:delete(Oid)
    end,
    mnesia:transaction(F).


% funs ------------------------------------
broadcast_msg(SceneId, _Pid, Msg) ->
    % Friends = select_friend(SceneId, Pid),
    Friends = select(SceneId),
    lists:foreach(fun(F) ->
        F#scene.pid ! {broadcast, Msg}
    end, Friends),
    ok.


