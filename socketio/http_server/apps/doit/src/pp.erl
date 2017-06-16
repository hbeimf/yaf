-module(pp).
-compile(export_all).






run() ->
    List = lists:seq(1, 54),
    List1 = shuffle(List),

    io:format("~p~n~n~p~n~n", [List, List1]).

shuffle(L) ->
    List1 = [{random(), X} || X <- L],
    List2 = lists:keysort(1, List1),
    [E || {_, E} <- List2].

random() ->
    {_, _, P3} = erlang:now(),
    random:uniform(P3).




