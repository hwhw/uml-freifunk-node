#!/bin/sh
cd $(dirname $0)
./start-network.sh &&
exec ./run-generic.sh \
    eth0=vde,/tmp/vde-default \
    "$@"
