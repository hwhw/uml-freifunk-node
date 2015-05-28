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
rm -rf "$RDIR"
mkdir "$RDIR"
touch "$RDIR/init.sh"
touch "$RDIR/sysconfig.sh"

function sysconfig() {
    echo "$1=\"$2\"" >> "$RDIR/sysconfig.sh"
}

function init() {
    cat >> "$RDIR/init.sh"
}

function new_file() {
    echo "cat >\"$1\" <<'ENDOFFILEMARKER'" >> "$RDIR/init.sh"
    init
    echo "ENDOFFILEMARKER" >> "$RDIR/init.sh"
}

function umlparam() {
    echo "$1" >> "$RDIR/cmdline"
}

sysconfig hostname "$HOSTNAME"
if [ -n "$1" ]; then source "$1"; fi

( echo "cat > /etc/sysconfig.sh <<'ENDOFCONFIG'"
  cat "$RDIR/sysconfig.sh"
  echo "ENDOFCONFIG"
) >> "$RDIR/init.sh"

chmod 0400 "$RDIR/init.sh"

exec linux/linux \
    umid=$HOSTNAME \
    uml_dir=$RDIR \
    mem=${mem:=40M} \
    ubda="$RDIR/init.sh" \
    con0=fd:0,fd:1 con=null \
    ssl=null \
    $(cat "$RDIR/cmdline")
    "$@"
