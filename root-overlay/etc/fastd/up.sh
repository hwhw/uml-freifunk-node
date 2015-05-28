#!/bin/sh
source /etc/sysconfig.sh
if [ -n "$fastd_mac" ]; then
    ip link set dev $INTERFACE address $fastd_mac
fi
ip link set dev $INTERFACE up

if [ "$batman_version" = "14" ]; then
    echo bat0 > /sys/class/net/$INTERFACE/batman_adv14/mesh_iface
else
    echo bat0 > /sys/class/net/$INTERFACE/batman_adv/mesh_iface
fi
