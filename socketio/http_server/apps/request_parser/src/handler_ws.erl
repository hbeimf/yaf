-module(handler_ws).
-behaviour(cowboy_websocket_handler).

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

-include("protocol_pb.hrl").

init({tcp, http}, _Req, _Opts) ->
    {upgrade, protocol, cowboy_websocket}.

%% -------------------------------------------------------------
websocket_init(_TransportName, Req, _Opts) ->
    % erlang:start_timer(1000, self(), <<"Hello!">>),
    SceneId = 1,
    table_scene:add(self(), SceneId) ,
    {ok, Req, undefined_state}.


%% 接收外部消息 ------------------------------------------------
websocket_handle({text, Msg}, Req, State) ->
    try
        Json = jsx:decode(Msg),
        Reply = ctrl_json:action(Json, State, self()),
        reply(Reply, Req, State)
    catch
        _Type:_What ->
            Reply1 = ctrl_str:action(Msg, State),
            reply(Reply1, Req, State)
    end;
websocket_handle({binary, Bin}, Req, State) ->
    BaseInfo = protocol_pb:decode_msg(Bin, 'Base'),
    Reply = ctrl_pb:action(BaseInfo#'Base'.id, BaseInfo#'Base'.data, State),
    reply(Reply, Req, State);
websocket_handle(Data, Req, State) ->
    error_logger:info_msg("recv data ~p ~n", [Data]),
    {ok, Req, State}.



%% 接收内部消息----------------------------------------------------

websocket_info({broadcast, Bin}, Req, State) ->
    {reply, {binary, to_binary(Bin)}, Req, State};
websocket_info({from_workboy, Msg}, Req, State) ->
    io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, Msg]),
    {reply, {text, Msg}, Req, State};
websocket_info({timeout, _Ref, Msg}, Req, State) ->
    % erlang:start_timer(1000, self(), <<"How' you doin'?">>),
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

%% -----------------------------------------------------------------
websocket_terminate(_Reason, _Req, _State) ->
    table_scene:delete(self()) ,
    ok.

% private fun ------------------------------------------------------
reply({reply_binary, NewStatus, ReplyBinary}, Req, _State) ->
    {reply, {binary, ReplyBinary}, Req, NewStatus};
reply({reply_json, NewStatus, ReplyJson}, Req, _State) ->
    % error_logger:info_msg("reply jsonxxxx ~p ~n", [ReplyJson]),
    {reply, {text, jsx:encode(ReplyJson)}, Req, NewStatus};
reply({reply_string, NewStatus, ReplyString}, Req, _State) ->
    {reply, {text, <<ReplyString/binary >>}, Req, NewStatus};
reply({noreply, NewStatus}, Req, _State) ->
    {ok, Req, NewStatus};
reply(_, Req, State) ->
    {ok, Req, State}.




to_binary(X) when is_list(X) -> list_to_binary(X);
to_binary(X) when is_atom(X) -> list_to_binary(atom_to_list(X));
to_binary(X) when is_binary(X) -> X;
to_binary(X) when is_integer(X) -> list_to_binary(integer_to_list(X));
to_binary(X) when is_float(X) -> list_to_binary(float_to_list(X));
to_binary(X) -> term_to_binary(X).

% to_str(X) when is_list(X) -> X;
% to_str(X) when is_atom(X) -> atom_to_list(X);
% to_str(X) when is_binary(X) -> binary_to_list(X);
% to_str(X) when is_integer(X) -> integer_to_list(X);
% to_str(X) when is_float(X) -> float_to_list(X).


% to_integer(X) when is_list(X) -> list_to_integer(X);
% to_integer(X) when is_binary(X) -> binary_to_integer(X);
% to_integer(X) when is_integer(X) -> X;
% to_integer(X) -> X.
