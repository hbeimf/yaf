-module(demo).
-compile(export_all).




run1() ->
    doit_server_parse_data:doit(),
    ok.

run() ->
    doit_fetch_web:doit(self()),
    ok.



