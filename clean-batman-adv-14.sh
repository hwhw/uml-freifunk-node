#!/bin/sh
cd batman-adv-legacy
make ARCH=um KERNELPATH=$(pwd)/../linux-4.0.3 clean
