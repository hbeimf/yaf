%%%-------------------------------------------------------------------
%% @doc redis top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(redis_sup).

-behaviour(supervisor).

%% Include
-include_lib("eunit/include/eunit.hrl").

%% API
-export([start_link/0, start_link/2]).
-export([create_pool/3, delete_pool/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    {ok, Pools} = application:get_env(redis, pools),
    {ok, GlobalOrLocal} = application:get_env(redis, global_or_local),
    start_link(Pools, GlobalOrLocal).

start_link(Pools, GlobalOrLocal) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, [Pools, GlobalOrLocal]).

%% ===================================================================
%% @doc create new pool.
%% @end
%% ===================================================================
-spec(create_pool(PoolName::atom(), Size::integer(), Options::[tuple()]) ->
             {ok, pid()} | {error,{already_started, pid()}}).

create_pool(PoolName, Size, Options) ->
    create_pool(local, PoolName, Size, Options).

%% ===================================================================
%% @doc create new pool, selectable name zone global or local.
%% @end
%% ===================================================================
-spec(create_pool(GlobalOrLocal::atom(), PoolName::atom(), Size::integer(), Options::[tuple()]) ->
             {ok, pid()} | {error,{already_started, pid()}}).

create_pool(GlobalOrLocal, PoolName, Size, Options)
  when GlobalOrLocal =:= local;
       GlobalOrLocal =:= global ->

    SizeArgs = [{size, Size}, {max_overflow, 10}],
    PoolArgs = [{name, {GlobalOrLocal, PoolName}}, {worker_module, eredis}],
    PoolSpec = poolboy:child_spec(PoolName, PoolArgs ++ SizeArgs, Options),

    supervisor:start_child(?MODULE, PoolSpec).

%% ===================================================================
%% @doc delet pool and disconnected to Redis.
%% @end
%% ===================================================================
-spec(delete_pool(PoolName::atom()) -> ok | {error,not_found}).

delete_pool(PoolName) ->
    supervisor:terminate_child(?MODULE, PoolName),
    supervisor:delete_child(?MODULE, PoolName).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([Pools, GlobalOrLocal]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 10,
    MaxSecondsBetweenRestarts = 10,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

    PoolSpecs = lists:map(fun({Name, SizeArgs, WorkerArgs}) ->
        PoolArgs = [{name, {GlobalOrLocal, Name}},
                    {worker_module, eredis}] ++ SizeArgs,
        poolboy:child_spec(Name, PoolArgs, WorkerArgs)
    end, Pools),

    {ok, {SupFlags, PoolSpecs}}.


% {ok,{{one_for_one,10,10},
%      [{default,{poolboy,start_link,
%                         [[{name,{local,default}},
%                           {worker_module,eredis},
%                           {size,5},
%                           {max_overflow,20}],
%                          []]},
%                permanent,5000,worker,
%                [poolboy]},
%       {pool1,{poolboy,start_link,
%                       [[{name,{local,pool1}},
%                         {worker_module,eredis},
%                         {size,5},
%                         {max_overflow,20}],
%                        [{host,"127.0.0.1"},{port,6379}]]},
%              permanent,5000,worker,
%              [poolboy]},
%       {pool2,{poolboy,start_link,
%                       [[{name,{local,pool2}},
%                         {worker_module,eredis},
%                         {size,5},
%                         {max_overflow,20}],
%                        [{host,"127.0.0.1"},
%                         {port,6379},
%                         {reconnect_sleep,100}]]},
%              permanent,5000,worker,
%              [poolboy]}]}}




