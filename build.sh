#!/bin/sh
cd $(dirname "$0")
./build-kernel.sh &&
./build-batman-adv-14.sh &&
./build-root.sh
