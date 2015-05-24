#!/bin/bash

MAX_NODES=256
TEMPDIR=/tmp
NET_NAME=$1
NET_NAME=${NET_NAME:=default}

cd $(dirname $0)
[ -d /tmp/vde-$NET_NAME ] && exit 0

[ -d /sys/class/net/vde-$NET_NAME ] || sudo ip tuntap add vde-$NET_NAME mode tap user $UID && sudo ip link set vde-$NET_NAME up
BRDEVVAR=BR_$NET_NAME
[ -z "${!BRDEVVAR}" ] || sudo brctl addif ${!BRDEVVAR} vde-$NET_NAME
vde_switch -n $MAX_NODES -t vde-$NET_NAME -s $TEMPDIR/vde-$NET_NAME -d -p $TEMPDIR/vde-$NET_NAME.pid
