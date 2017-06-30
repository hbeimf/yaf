#!/bin/sh

mvn compile
mvn assembly:assembly


cp ./target/java-node-0.0.1-jar-with-dependencies.jar ../../priv/
