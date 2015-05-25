#!/bin/sh
cd $(dirname $0)/batman-adv-legacy
make ARCH=um KERNELPATH=$(pwd)/../linux &&
make -C $(pwd)/../batman-adv-legacy/../linux ARCH=um M=$(pwd)/../batman-adv-legacy PWD=$(pwd)/../batman-adv-legacy INSTALL_MOD_PATH=$(pwd)/../root-modules/ INSTALL_MOD_DIR=updates/net/batman-adv14/ modules_install
