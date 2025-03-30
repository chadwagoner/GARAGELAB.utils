#!/bin/sh

### USER INPUT VARIABLES
read -p 'NFS SERVER IP ADDRESS: ' nfs_server < /dev/tty
read -p 'NFS BACKUP VOLUME: ' nfs_volume < /dev/tty

### CREATE BACKUP DIRECTORY
doas mkdir -p /mnt/backup
doas chown alpine:alpine /mnt/backup

### UPDATE FSTAB
echo -e "$nfs_server:$nfs_volume /mnt/backup nfs rw,vers=4,rsize=32768,wsize=32768,soft 0 0" | doas tee -a /etc/fstab >/dev/null

### MOUNT
doas mount -a
