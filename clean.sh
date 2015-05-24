#!/bin/sh
cd $(dirname $0)
rm -rf root/*
rm -rf root-modules/*
./clean-buildroot.sh
./clean-batman-adv-14.sh
./clean-kernel.sh
