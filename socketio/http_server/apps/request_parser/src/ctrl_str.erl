%%%-------------------------------------------------------------------
%% @doc controller_image public API
%% @end
%%%-------------------------------------------------------------------

-module(ctrl_str).
-compile(export_all).
% -export([run/3]).

action(String, Status) ->
    % NewString = <<"hello中国">>,


     % io:format("file: ~p =========== \nline:~p =========== ~n~n ~p ~n~n", [?FILE, ?LINE, {NewString, String}]),
    {reply_string, Status, String}.


% to_binary(X) when is_list(X) -> list_to_binary(X);
% to_binary(X) when is_atom(X) -> list_to_binary(atom_to_list(X));
% to_binary(X) when is_binary(X) -> X;
% to_binary(X) when is_integer(X) -> list_to_binary(integer_to_list(X));
% to_binary(X) when is_float(X) -> list_to_binary(float_to_list(X));
% to_binary(X) -> term_to_binary(X).
