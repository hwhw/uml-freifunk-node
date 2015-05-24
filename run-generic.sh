#!/bin/sh
cd $(dirname $0)
exec linux/linux \
    mem=${mem:=32M} \
    rootfstype=hostfs \
    hostfs=root/ \
    init=/init \
    con0=${console:=fd:0,fd:1} con=null ssl=null \
    "$@"
