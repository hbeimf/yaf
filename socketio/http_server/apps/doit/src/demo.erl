-module(demo).
-compile(export_all).




rr() ->
    doit_server_parse_data:doit(),
    ok.

run() ->
    doit_fetch_web:doit(self()),
    ok.



