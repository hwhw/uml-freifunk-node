#!/bin/sh
cd $(dirname "$0")/buildroot
make $MAKE_OPTS BR2_EXTERNAL=$(pwd)/../buildroot-external &&
    cd .. &&
    rm -rf root/* &&
    cd root &&
    (tar xvf ../buildroot/output/images/rootfs.tar || true ) &&
    cp -a ../root-modules/* ./ &&
    cp -a ../root-overlay/* ./
