%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(handler_protobuff).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-include_lib("kernel/include/file.hrl").


init(_Type, Req, []) ->
    {ok, Req, undefined}.

% http://www.xxxx.com:8080/protocol.proto
handle(Req, State) ->
    Dir = code:lib_dir(request_parser, priv) ++ "/protocol.proto",
    error_logger:info_msg("dir XXX  ~p~n", [Dir]),

    {_, Info} = file:read_file_info(Dir, [{time, universal}]),

    Body = case file_get_contents(Dir) of
        {ok, Bin} ->
            Bin;
        {error, _Msg} ->
            <<"hello world!!">>
    end,

    Date = cowboy_clock:rfc1123(Info#file_info.mtime),

    {ok, Req2} = cowboy_req:reply(200, [
        {<<"last-modified">>, Date},
        {<<"content-type">>, <<"text/plain">>}

    ], Body, Req),

    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

file_get_contents(Dir) ->
    case file:read_file(Dir) of
        {ok, Bin} ->
            {ok, Bin};
        {error, Msg} ->
            {error, Msg}
    end.

