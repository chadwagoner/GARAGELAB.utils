#!/bin/sh

### INSTALL NFS PACKAGES
doas apk add -U nfs-utils

### ENABLE BOOT START
doas rc-update add nfsmount boot

### START SERVICE
doas rc-service nfsmount start