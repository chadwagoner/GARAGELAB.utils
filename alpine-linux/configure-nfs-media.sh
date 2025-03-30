#!/bin/sh

### USER INPUT VARIABLES
read -p 'NFS SERVER IP ADDRESS: ' nfs_server < /dev/tty
read -p 'NFS MEDIA VOLUME: ' nfs_volume < /dev/tty

### CREATE MEDIA DIRECTORY
doas mkdir -p /mnt/media
doas chown alpine:alpine /mnt/media

### UPDATE FSTAB
echo -e "$nfs_server:$nfs_volume /mnt/media nfs rw,vers=4,rsize=32768,wsize=32768,soft 0 0" | doas tee -a /etc/fstab >/dev/null

### MOUNT
doas mount -a
