#!/bin/sh
cd $(dirname $0)/linux-*
cp ../linux.config ./.config
make -j4 ARCH=um &&
cp -a linux .. &&
make ARCH=um INSTALL_MOD_PATH=$(pwd)/../root-modules/ modules_install
