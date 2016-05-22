#!/bin/bash

sudo umount /dev/sdb1
sudo umount /dev/sdb2

KERNEL=kernel7
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs

sudo mount /dev/sdb1 mnt/fat32
sudo mount /dev/sdb2 mnt/ext4

sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=mnt/ext4 modules_install
sudo cp mnt/fat32/$KERNEL.img mnt/fat32/$KERNEL-backup.img
sudo scripts/mkknlimg arch/arm/boot/zImage mnt/fat32/$KERNEL.img
sudo cp arch/arm/boot/dts/*.dtb mnt/fat32/
sudo cp arch/arm/boot/dts/overlays/*.dtb* mnt/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/README mnt/fat32/overlays/
#sudo umount mnt/fat32
#sudo umount mnt/ext4
