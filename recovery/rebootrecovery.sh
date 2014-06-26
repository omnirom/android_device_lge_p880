#!/sbin/sh

echo "boot-recovery" | /sbin/dd of=/dev/block/mmcblk0p5 bs=1 count=13
