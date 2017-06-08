%%%-------------------------------------------------------------------
%% @doc tpl.
%% @end
%%%-------------------------------------------------------------------

-module(tpl).

%% API
-export([compile/3]).

compile(TemplateName, DataList, Handler) ->
    case code:priv_dir(request_parser) of
        {error,bad_name} ->
            <<"can't find tpl !!">>;
        Dir ->
            TemplateDir = Dir ++ "/tpl/" ++ TemplateName,
            erlydtl:compile_file( TemplateDir, Handler, [
                {out_dir, false}
                % {custom_filters_modules, [lib_filter]},
                % {custom_tags_modules, [lib_tags]}
            ]),
            {ok, List} = Handler:render(DataList),
            iolist_to_binary(List)
    end.

