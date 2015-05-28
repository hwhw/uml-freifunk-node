#!/bin/sh
source /etc/sysconfig.sh
[ -n "$alfred_send_data" ] && [ "$alfred_send_data" == "1" ] || exit 0
if [ "$batman_version" == "14" ]; then
    BPATH=batman_adv14
else
    BPATH=batman_adv
fi
[ -d /sys/class/net/br-client ] || exit 0
[ -d /sys/class/net/mesh-vpn ] || exit 0

ALFRED=/usr/sbin/alfred

logger "updating alfred data"

MAC=$(cat /sys/class/net/br-client/address)
NODE_ID=$(echo $MAC|sed 's/://g')

NODEINFO='{"node_id":"'$NODE_ID'","network":{"mac":"'$MAC'","addresses":['
NODEINFO=$NODEINFO$(ip addr show dev br-client | awk '/ *inet6 / {sub("/.*","",$2); printf(KOMMA "\"" $2 "\""); KOMMA=","}')
NODEINFO=$NODEINFO'],"mesh_interfaces":['
KOMMA=""
for i in mesh-vpn; do
    NODEINFO=$NODEINFO'"'$(cat /sys/class/net/$i/address)'"'$KOMMA
    KOMMA=","
done
NODEINFO=$NODEINFO']},"hostname":"'$(hostname)'","hardware":{"model":"'${node_model:=Nimbus 2000}
NODEINFO=$NODEINFO'"},"owner":{"contact":"'${node_contact:=hedwig@owlery.hw}'"},'
NODEINFO=$NODEINFO'"software":{"fastd":{"enabled":'$(killall -0 fastd && echo "true" || echo "false")',"version":"'$(fastd --version|awk '{print $2}')
NODEINFO=$NODEINFO'"},"batman-adv":{"compat":14,"version":"2013.4.0"},'
NODEINFO=$NODEINFO'"firmware":{"base":"'${node_base:=lucy}'","release":"'${node_release:=My Milkshake is better than yours}'"}},"system":[]}'

echo $NODEINFO | gzip | $ALFRED -s 158

STATS='{"node_id":"'$NODE_ID'","clients":{"wifi":0,"total":0},"rootfs_usage":0.070075757575758,'
STATS=$STATS'"traffic":{"tx":{"packets":'$(cat /sys/class/net/bat0/statistics/tx_packets)','
STATS=$STATS'"dropped":'$(cat /sys/class/net/bat0/statistics/tx_dropped)',"bytes":'$(cat /sys/class/net/bat0/statistics/tx_bytes)'},'
STATS=$STATS'"rx":{"bytes":'$(cat /sys/class/net/bat0/statistics/rx_bytes)',"packets":'$(cat /sys/class/net/bat0/statistics/rx_packets)'},'
STATS=$STATS'"forward":{"bytes":0,"packets":0},'
STATS=$STATS'"mgmt_tx":{"bytes":0,"packets":0},'
STATS=$STATS'"mgmt_rx":{"bytes":0,"packets":0}},'
MEM_cached=$(awk '/^Cached:/{print $2}' /proc/meminfo)
MEM_total=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)
MEM_buffers=$(awk '/^Buffers:/{print $2}' /proc/meminfo)
MEM_free=$(awk '/^MemFree:/{print $2}' /proc/meminfo)
STATS=$STATS'"memory":{"cached":'$MEM_cached',"total":'$MEM_total',"buffers":'$MEM_buffers',"free":'$MEM_free'},'
STATS=$STATS$(awk '{print "\"uptime\":" $1 ",\"idletime\":" $2}' /proc/uptime)
STATS=$STATS$(awk '/^=>/ {print ",\"gateway\":\"" $2 "\""}' /sys/kernel/debug/$BPATH/bat0/gateways)
STATS=$STATS',"mesh_vpn":{"vpn2":{"established":100},"vpn1":{"established":100},"vpn3":{"established":100}}'
STATS=$STATS',"processes":{"total":42,"running":1},'
STATS=$STATS'"loadavg":'$(awk '{print $2}' /proc/loadavg)'}'

echo $STATS | gzip | $ALFRED -s 159
