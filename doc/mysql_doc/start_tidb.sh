#! /bin/bash

./bin/pd-server --data-dir=pd > pd-server.log 2>&1 &
./bin/tikv-server --pd="127.0.0.1:2379" --store=tikv > tikv-server.log 2>&1 &
./bin/tidb-server --store=tikv --path="127.0.0.1:2379" > tidb-server.log 2>&1 &

