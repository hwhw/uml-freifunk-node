#!/bin/bash

TEMPDIR=/tmp
NET_NAME=$1
NET_NAME=${NET_NAME:=default}

cd $(dirname $0)
[ -d /tmp/vde-$NET_NAME ] || exit 1
kill $(cat /tmp/vde-$NET_NAME.pid)

[ -d /sys/class/net/vde-$NET_NAME ] && sudo ip tuntap del vde-$NET_NAME mode tap
