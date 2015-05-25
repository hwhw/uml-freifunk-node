#!/bin/sh
cd $(dirname $0)/linux
cp ../linux.config ./.config
make ARCH=um menuconfig
cp .config ../linux.config
