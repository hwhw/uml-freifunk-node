#!/bin/sh

MACAPPENDIX=08:15

cd $(dirname $0)
./start-network.sh ffgoe &&
exec ./run-networked.sh \
    hostname=some-gateway15 \
    fastd_enabled=1 \
    fastd_port=12346 \
    fastd_anon=1 \
    fastd_mac=8e:ff:ff:ff:$MACAPPENDIX \
    fastd_secret=123456789012345678901e34c4bd949edb225260541e3cb2a3a13f36c4f621277 \
    batman_role=server \
    batman_mac=1a:ff:ff:ff:$MACAPPENDIX \
    batman_inner=eth1 \
    inet_mac=8e:ff:ff:ff:$MACAPPENDIX \
    eth1=vde,/tmp/vde-ffgoe \
    "$@"
