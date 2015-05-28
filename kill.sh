#!/bin/sh
cd $(dirname $0)

if [ -n "$1" ]; then
    HOSTNAME=$(basename "$1")
    if [ -n "$2" ]; then
        HOSTNAME="$HOSTNAME-$2"
    fi
else
    HOSTNAME="uml"
fi

RDIR="/tmp/uml.$UID.$HOSTNAME"

if [ -f "$RDIR/$HOSTNAME/pid" ]; then
    kill $(cat "$RDIR/$HOSTNAME/pid") &&
    rm -rf "$RDIR"
fi
