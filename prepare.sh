#!/bin/sh
cd $(dirname "$0")
git submodule init
git submodule update
wget -O - https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.0.4.tar.xz | tar xvJf -
ln -s linux-4.0.4 linux
