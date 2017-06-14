%%%-------------------------------------------------------------------
%% @doc go public API
%% @end
%%%-------------------------------------------------------------------

-module(go_cast).
-compile(export_all).

%% Application callbacks

% api =====================================

% start_goroutine() ->
%     go_server:start_goroutine().

% stop_goroutine(GoMBox) ->
%     go_server:stop_goroutine(GoMBox).


% info() ->

%     go_server:info().


t() ->
    send_cast(pings).

tt() ->
    List = [{name, "xiaomin"}, {email, "123456@qq.com"}],
    send_cast(List).


send_cast(Cast) ->
    {ok, GoMBox} = application:get_env(go, go_mailbox),

    % Utf8Name = unicode:characters_to_binary("xiaomin小明"),
    % Json = jsx:encode(#{name=>Utf8Name, email=><<"123456@gmail.com">>, age=> 1}),

    % Cast = {json, Json},
    % Cast = ping,

    go_server:send_cast(GoMBox, Cast),

    % stop_goroutine(GoMBox),
    ok.
    % Reply.

%%====================================================================
%% Internal functions
%%====================================================================
