%%%-------------------------------------------------------------------
%% @doc go public API
%% @end
%%%-------------------------------------------------------------------

-module(java).
-compile(export_all).




test() ->
	{'JavaMBox', 'java_node@127.0.0.1'} ! {self(), "hello world xxxxX"},
	receive
		{_, Msg} ->
			io:format("msg:~p~n~n", [Msg]),
			ok;
		_ ->
			ok
	end,
	ok.
