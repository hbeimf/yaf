#!/bin/bash

mvn clean scala:compile compile package

mvn assembly:assembly

