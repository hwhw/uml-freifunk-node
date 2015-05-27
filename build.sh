#!/bin/sh
cd $(dirname "$0")
./build-modules.sh &&
./build-root.sh &&
./build-kernel.sh
