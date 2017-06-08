%%%-------------------------------------------------------------------
%% @doc controller_image public API
%% @end
%%%-------------------------------------------------------------------

-module(ctrl_pb).
-compile(export_all).
% -export([run/3]).

-include("protocol_pb.hrl").


% 聊天广播
action(10000, BinString, Status) ->
    _Msg = protocol_pb:decode_msg(BinString, 'ChatMsg'),
    ReplyBin = protocol_pb:encode_msg(#'Base'{id=10000, data=BinString}),

    SceneId = 1,
    table_scene:broadcast_msg(SceneId, self(), ReplyBin),

    {noreply, Status};


action(10001, _BinString, Status) ->
    People = protocol_pb:encode_msg(#'People'{id=1256, name="python获取当前日期", email="5556666@qq.com"}),
    ReplyBin = protocol_pb:encode_msg(#'Base'{id=10001, data=People}),
    % ReplyBin = protocol_pb:encode_msg(#'Base'{id=10001, data=BinString}),

    {reply_binary, Status, ReplyBin};



action(20000, _BinString, Status) ->
    io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, "BinString"]),
    Msg = protocol_pb:encode_msg(#'Msg'{msg="分析yid"}),
    ReplyBin = protocol_pb:encode_msg(#'Base'{id=20000, data=Msg}),

    io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, ReplyBin]),
    % ReplyBin = protocol_pb:encode_msg(#'Base'{id=10001, data=BinString}),

    Work = {find_yid, self()},
    workboy:start(Work),

    {reply_binary, Status, ReplyBin};

action(20001, _BinString, Status) ->
    io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, "BinString"]),
    Msg = protocol_pb:encode_msg(#'Msg'{msg="查看分析结果"}),
    ReplyBin = protocol_pb:encode_msg(#'Base'{id=20000, data=Msg}),

    io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, ReplyBin]),
    % ReplyBin = protocol_pb:encode_msg(#'Base'{id=10001, data=BinString}),

    Work = {show_result, self()},
    workboy:start(Work),

    {reply_binary, Status, ReplyBin};

action(20002, _BinString, Status) ->
    io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, "BinString"]),
    Msg = protocol_pb:encode_msg(#'Msg'{msg="更新数据"}),
    ReplyBin = protocol_pb:encode_msg(#'Base'{id=20000, data=Msg}),

    io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, ReplyBin]),
    % ReplyBin = protocol_pb:encode_msg(#'Base'{id=10001, data=BinString}),

    Work = {init_data, self()},
    workboy:start(Work),

    {reply_binary, Status, ReplyBin};


action(_PId, _BinString, Status) ->
    % Msg = protocol_pb:encode_msg(#'Msg'{msg="未定义的功能"}),
    % ReplyBin = protocol_pb:encode_msg(#'Base'{id=20000, data=Msg}),
    % {reply_binary, Status, ReplyBin}.

    % 回复中文的方法
    Utf8 = unicode:characters_to_binary("未定义的功能"),
    {reply_string, Status, Utf8}.

