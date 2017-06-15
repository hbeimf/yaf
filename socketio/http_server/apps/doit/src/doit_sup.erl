%%%-------------------------------------------------------------------
%% @doc doit top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(doit_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
% init([]) ->
%     {ok, { {one_for_all, 0, 1}, []} }.

init([]) ->
    Doit = {doit_server_tpl, {doit_server_tpl, start_link, []},
               permanent, 5000, worker, [doit_server_tpl]},

    FetchWeb = {doit_fetch_web, {doit_fetch_web, start_link, []},
               permanent, 5000, worker, [doit_fetch_web]},

    Add = {doit_server_add, {doit_server_add, start_link, []},
               permanent, 5000, worker, [doit_server_add]},


    Children = [Doit, FetchWeb, Add],

    {ok, { {one_for_all, 10, 10}, Children} }.



%%====================================================================
%% Internal functions
%%====================================================================
