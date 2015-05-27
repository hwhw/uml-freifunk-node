#!/bin/sh
cd $(dirname "$0")/buildroot
cp ../buildroot.config ./ &&
make $MAKE_OPTS BR2_EXTERNAL=$(pwd)/../buildroot-external
