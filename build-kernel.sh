#!/bin/sh
cd $(dirname $0)/linux
cp ../linux.config ./.config
[ -f linux ] && mv linux linux.O
make -j4 ARCH=um &&
make ARCH=um INSTALL_MOD_PATH=$(pwd)/../root-modules/ modules_install
