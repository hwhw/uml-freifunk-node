#!/bin/sh
cd $(dirname $0)/linux-*
make -j4 ARCH=um clean
