#!/bin/bash


set -xe


#wget http://www.merlinthp.org/arm/image3/CentOS-7-armv7hl-sda-03.raw.xz
#unxz -v CentOS-7-armv7hl-sda-03.raw.xz


# root@docker-builder-5:~/centos-img# fdisk -l ./CentOS-7-armv7hl-sda-03.raw
# 
# Disk ./CentOS-7-armv7hl-sda-03.raw: 4 GiB, 4311744512 bytes, 8421376 sectors
# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disklabel type: dos
# Disk identifier: 0x9c724bd1
# 
# Device                         Boot   Start     End Sectors  Size Id Type
# ./CentOS-7-armv7hl-sda-03.raw1 *       2048  393215  391168  191M  c W95 FAT32 (LBA)
# ./CentOS-7-armv7hl-sda-03.raw2       393216 1392639  999424  488M  c W95 FAT32 (LBA)
# ./CentOS-7-armv7hl-sda-03.raw3      1392640 8032255 6639616  3.2G 83 Linux


rm -rf rootfs && mkdir ./rootfs
mount -o loop,offset=$((1392640 * 512)) CentOS-7-armv7hl-sda-03.raw ./rootfs
tar -C ./rootfs/ -jcf centos-img.tar.xz .
umount ./rootfs

docker build -t armbuild/centos-img:merlinthp-2015-03-16 .
