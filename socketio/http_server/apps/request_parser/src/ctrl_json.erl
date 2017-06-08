%%%-------------------------------------------------------------------
%% @doc controller_image public API
%% @end
%%%-------------------------------------------------------------------

-module(ctrl_json).
-compile(export_all).
% -export([run/3]).

action(Json, Status, Pid) ->
    case lists:keytake(<<"cmd">>, 1, Json) of
        false ->
            action(undefined, Json, Status, Pid);
        {_, {_, Cmd}, _} ->
            action(Cmd, Json, Status, Pid)
    end.

action(<<"fetchWeb">>, _Json, Status, Pid) ->
    Work = {fetch_web, Pid},
    workboy:start(Work),
    {noreply, Status};
action(<<"readMysql">>, _Json, Status, Pid) ->
    Work = {read_mysql, Pid},
    workboy:start(Work),
    {noreply, Status};
action(<<"sendJson">>, Json, Status, _Pid) ->
     io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, Json]),
    {reply_json, Status, Json};
action(<<"uploadImage">>, Json, Status, _Pid) ->
    Res = case lists:keytake(<<"type">>, 1, Json) of
        false ->
            error_logger:info_msg("receive json ~p~n", [Json]),
            % reply(json, Pid, Json);
            Json;
        {_, {<<"type">>, Type}, _} ->
            {_, {<<"message">>, FileBase64Content}, _} = lists:keytake(<<"message">>, 1, Json),

            Con = base64:mime_decode(FileBase64Content),

            FileName = "fff",
            Tail = get_tail(Type),

            Dir = code:lib_dir(http_server, priv) ++ "/static/upload/"++ FileName ++"." ++ Tail,
            error_logger:info_msg("dir  ~p~n", [Dir]),

            % Dir = "/web/erl/websocket_and_socketio_upgrade_demo/"++ FileName ++"." ++ Tail,
            % Dir = "/web/erl/websocket_and_socketio_upgrade_protobuf_demo/"++ FileName ++"." ++ Tail,

            file_put_contents(Dir, Con),
            {ok, Con} = file_get_contents(Dir),
            Reply = to_binary(base64:encode_to_string(Con)),
            Reply1 = [{<<"userName">>,<<"image">>},
                        {<<"type">>,<<"jpeg">>},
                      {<<"message">>, Reply}],
            Reply1
    end,
    {reply_json, Status, Res};
action(_, _Json, Status, _Pid) ->
    {noreply, Status}.


% priv fun -------------------


get_tail(<<"data:text/plain;">>) ->
    "txt";
get_tail(<<"data:image/jpeg;">>) ->
    "jpeg";
get_tail(_) ->
    "txt".

file_get_contents(Dir) ->
    case file:read_file(Dir) of
        {ok, Bin} ->
            % {ok, binary_to_list(Bin)};
            {ok, Bin};
        {error, Msg} ->
            {error, Msg}
    end.

file_put_contents(Dir, Str) ->
    file:write_file(Dir, to_binary(Str)).

to_binary(X) when is_list(X) -> list_to_binary(X);
to_binary(X) when is_atom(X) -> list_to_binary(atom_to_list(X));
to_binary(X) when is_binary(X) -> X;
to_binary(X) when is_integer(X) -> list_to_binary(integer_to_list(X));
to_binary(X) when is_float(X) -> list_to_binary(float_to_list(X));
to_binary(X) -> term_to_binary(X).





