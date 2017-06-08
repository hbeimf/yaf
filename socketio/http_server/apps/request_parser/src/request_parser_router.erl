% %%%-------------------------------------------------------------------
% %% @doc request parser router
% %% @end
% %%%-------------------------------------------------------------------
-module(request_parser_router).

-export([get_cmd/1, get_router/1, test/1]).



get_cmd(Json) ->
     case lists:keytake(<<"cmd">>, 1, Json) of
        false ->
            undefined;
        {_, {_, Cmd}, _} ->
            Cmd
    end.

get_router(Cmd)  ->
    Router = [
        {controller_demo, [<<"readMysql">>, <<"uploadImage">>, <<"sendJson">>, <<"fetchWeb">>]}
    ],

    ReplyAction = lists:foldl(fun({Action, CmdList}, Reply) ->
        case lists:member(Cmd, CmdList) of
            true ->
                [Action|Reply];
            _ ->
                Reply
        end
    end, [], Router),

    case length(ReplyAction) of
        0 ->
            controller_default;
        _ ->
            [Action|_] = ReplyAction,
            Action
    end;
get_router(_) ->
    controller_default.

%% --
test(1) ->
    Json = [{<<"cmd">>,<<"getImage">>},
              {<<"message">>,<<"send json ...">>}],

    Cmd = get_cmd(Json),
    get_router(Cmd);
test(2) ->
    Json = [{<<"cmd">>,<<"setImage">>},
              {<<"message">>,<<"send json ...">>}],

    Cmd = get_cmd(Json),
    get_router(Cmd);
test(3) ->
    Json = [{<<"nocmd">>,<<"setImage">>},
              {<<"message">>,<<"send json ...">>}],

    Cmd = get_cmd(Json),
    get_router(Cmd);
test(_) ->
    Json = [{<<"cmd">>,<<"getImagexxxxx">>},
              {<<"message">>,<<"send json ...">>}],

    Cmd = get_cmd(Json),
    get_router(Cmd).


