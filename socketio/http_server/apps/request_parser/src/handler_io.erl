% %%%-------------------------------------------------------------------
% %% @doc socketio callback handler
% %% @end
% %%%-------------------------------------------------------------------
-module(handler_io).

-export([open/3, recv/4, handle_info/4, close/3]).
% -record(session_state, {}).
-include("protocol_pb.hrl").

%% ---- Handlers
% 客户端打开连接
open(_Pid, Sid, _Opts) ->
    % erlang:send_after(5000, self(), tick),
    % error_logger:info_msg("open ~p ~p~n", [Pid, Sid]),
    % demo_mgr:add_session(Pid),
    SceneId = 1,
    % table_scene:add(self(), SceneId) ,

    Status = #{
        nickname => "xiao min",
        age => 0,
        pid => self(),
        sid => Sid,
        scene_id => SceneId
    },
    {ok, Status}.

% 接收来自客户端的消息

%% 接收json
recv(Pid, _Sid, {json, <<>>, Json}, Status) ->
    case ctrl_json:action(Json, Status, Pid) of
        {reply_json, NewStatus, ReplyJson} ->
            reply(json, Pid, ReplyJson),
            {ok, NewStatus};
        {reply_string, NewStatus, ReplyString} ->
            reply(string, Pid, ReplyString),
            {ok, NewStatus};
        {noreply, NewStatus} ->
            {ok, NewStatus};
        _ ->
            {ok, Status}
    end;
%% 接收字符串, buff
recv(Pid, _Sid, {message, <<>>, Message}, Status) ->
    % try
    %     % error_logger:info_msg("recv binary ~p ~p~n", [Pid, Message]),
    %     % 去掉两端的引号, 不然解码会出错
    %     Con = del_quotes(Message),
    %     % error_logger:info_msg("del quotes ~p ~p~n", [Pid, Con]),

    %     BaseInfo = protocol_pb:decode_msg(Con, 'Base'),
    %     % error_logger:info_msg("recv yyy ~p ~p~n", [Pid, BaseInfo]),

    %     case ctrl_pb:action(BaseInfo#'Base'.id, BaseInfo#'Base'.data, Status) of
    %         {reply_binary, NewStatus, ReplyBin} ->
    %             reply(binary, Pid, ReplyBin),
    %             {ok, NewStatus};
    %         {reply_json, NewStatus, ReplyJson} ->
    %             reply(json, Pid, ReplyJson),
    %             {ok, NewStatus};
    %         {reply_string, NewStatus, ReplyString} ->
    %             reply(string, Pid, ReplyString),
    %             {ok, NewStatus};
    %         {noreply, NewStatus} ->
    %             {ok, NewStatus};
    %         _ ->
    %             {ok, Status}
    %     end
    % catch
    %     Type:What ->
    %         error_logger:info_msg("recv message ~p ~p~n", [Pid, Message]),
    %         error_logger:info_msg("type ~p what: ~p~n", [Type, What]),

            case ctrl_str:action(Message, Status) of
                {reply_json, NewStatus1, ReplyJson1} ->
                    reply(json, Pid, ReplyJson1),
                    {ok, NewStatus1};
                {reply_string, NewStatus1, ReplyString1} ->
                    reply(string, Pid, ReplyString1),
                    {ok, NewStatus1};
                {noreply, NewStatus1} ->
                    {ok, NewStatus1};
                _ ->
                    {ok, Status}
            end;
    % end;

%% 其它类型的消息
recv(Pid, Sid, Message, Status) ->
    error_logger:info_msg("recv other ~p ~p ~p~n", [Pid, Sid, Message]),
    {ok, Status}.


% 接收来自系统的消息
handle_info(Pid, _Sid, {from_workboy, Message}, Status) ->
    % error_logger:info_msg("from_workboy:~p~n...", [Message]),

    reply(string, Pid, Message),

    {ok, Status};
handle_info(_Pid, _Sid, tick, Status) ->
    % error_logger:info_msg("Tick...", []),
    {ok, Status};
handle_info(_Pid, _Sid, _Info, Status) ->
    {ok, Status}.


% 客户端关闭连接
close(Pid, Sid, _Status) ->
    error_logger:info_msg("close ~p ~p~n", [Pid, Sid]),
    % demo_mgr:remove_session(Pid),
    % table_scene:delete(self()) ,
    ok.


%% -------------------------------------------------------------
%% private functions
%% -------------------------------------------------------------

% reply(binary, Pid, Bin) ->
%     socketio_session:send(Pid, Bin);
reply(json, Pid, Json) ->
    socketio_session:send_obj(Pid, Json);
reply(string, Pid, String) ->
    socketio_session:send_message(Pid, to_binary(String)).


% funs

% del_quotes(Bin) ->
%     Str = to_str(Bin),
%     List = explode(Str, ","),
%     R = lists:foldr(fun(L, Res) ->
%         [to_integer(L)|Res]
%     end, [], List),
%     to_binary(R).

% to_integer(X) when is_list(X) -> list_to_integer(X);
% to_integer(X) when is_binary(X) -> binary_to_integer(X);
% to_integer(X) when is_integer(X) -> X;
% to_integer(X) -> X.

% to_str(X) when is_list(X) -> X;
% to_str(X) when is_atom(X) -> atom_to_list(X);
% to_str(X) when is_binary(X) -> binary_to_list(X);
% to_str(X) when is_integer(X) -> integer_to_list(X);
% to_str(X) when is_float(X) -> float_to_list(X).

to_binary(X) when is_list(X) -> list_to_binary(X);
to_binary(X) when is_atom(X) -> list_to_binary(atom_to_list(X));
to_binary(X) when is_binary(X) -> X;
to_binary(X) when is_integer(X) -> list_to_binary(integer_to_list(X));
to_binary(X) when is_float(X) -> list_to_binary(float_to_list(X));
to_binary(X) -> term_to_binary(X).

% explode(Str, SubStr) ->
%     case string:len(Str) of
%         Length when Length == 0 ->
%             [];
%         _Length ->
%             explode(Str, SubStr, [])
%     end.

% explode(Str, SubStr, List) ->
%     case string:str(Str, SubStr) of
%         Pos when Pos == 0 ->
%             List ++ [Str];
%         Pos when Pos == 1 ->
%             LengthStr = string:len(Str),
%             LengthSubStr = string:len(SubStr),
%             case LengthStr - LengthSubStr of
%                 Length when Length =< 0 ->
%                     List;
%                 Length ->
%                     LastStr = string:substr(Str, LengthSubStr + 1, Length),
%                     explode(LastStr, SubStr, List)
%             end;
%         Pos ->
%             Head = string:substr(Str, 1, Pos -1),
%             Tail = string:substr(Str, Pos),
%             explode(Tail, SubStr, List ++ [Head])
%     end.

% implode(List, Str) ->
%     string:join(List, Str).
