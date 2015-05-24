#!/bin/sh

PEERS=550af47507836d6684bddf0299c720a9a4ac08e62e53b23765d6d44c97f6ff8d
PEERS=$PEERS@ipv4
PEERS=$PEERS@1.vpn.freifunk-goettingen.de
PEERS=$PEERS@12345
PEERS=$PEERS,c296da27b87338fa247ceac17f5dc2bc39ec4182bfbb18f8c6e50eeae82bf65a
PEERS=$PEERS@ipv4
PEERS=$PEERS@2.vpn.freifunk-goettingen.de
PEERS=$PEERS@12345
PEERS=$PEERS,6c728976dd225bd69cc93da238b11d18f70028497ffbb8670351560ab2da6193
PEERS=$PEERS@ipv4
PEERS=$PEERS@3.vpn.freifunk-goettingen.de
PEERS=$PEERS@12345

cd $(dirname $0)
./start-network.sh ffgoe &&
exec ./run-networked.sh \
    hostname=some-node \
    fastd_enabled=1 \
    fastd_mac=8e:ff:ff:12:34:56 \
    fastd_secret=1234567890ab53a1fe852291c93b4428da4e65b97649c6b995806830a0d02540 \
    fastd_peers=$PEERS \
    fastd_limit=2 \
    alfred_send_data=1 \
    batman_version=14 \
    batman_role=client \
    batman_mac=1a:ff:ff:12:34:56 \
    batman_mesh=eth0 \
    batman_inner=eth1 \
    eth1=vde,/tmp/vde-ffgoe \
    "$@"
