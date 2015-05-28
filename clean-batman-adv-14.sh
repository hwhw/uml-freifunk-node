#!/bin/sh
cd batman-adv-legacy
make ARCH=um KERNELPATH=$(pwd)/../linux clean
