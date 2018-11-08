#!/bin/bash
rm -r imatge2

tar -czvf openwrt-18.06.1-x86-generic-generic-rootfs2.tar.gz -C imatge/ .

mkdir imatge2

tar -xzvf openwrt-18.06.1-x86-generic-generic-rootfs2.tar.gz -C imatge2/
mv openwrt-18.06.1-x86-generic-generic-rootfs2.tar.gz openwrt-18.06.1-x86-generic-generic-rootfs.tar.gz

docker build -t rabbyte/docker_pti:bmx6 .
