-module(demo).
-compile(export_all).




rr() ->
    ok.

run() ->
    doit_fetch_web:doit(self()),
    ok.

