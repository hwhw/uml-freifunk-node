#!/bin/sh
cd $(dirname $0)
[ -d root-modules ] && rm -rf root-modules/* || mkdir root-modules

cd linux &&
cp ../linux.config ./.config &&
make -j4 ARCH=um modules &&
make ARCH=um INSTALL_MOD_PATH=$(pwd)/../root-modules/ modules_install &&
cd ../batman-adv-legacy &&
make ARCH=um KERNELPATH=$(pwd)/../linux &&
make -C $(pwd)/../batman-adv-legacy/../linux ARCH=um M=$(pwd)/../batman-adv-legacy PWD=$(pwd)/../batman-adv-legacy INSTALL_MOD_PATH=$(pwd)/../root-modules/ INSTALL_MOD_DIR=updates/net/batman-adv14/ modules_install
