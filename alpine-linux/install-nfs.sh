#!/bin/sh

### INSTALL NFS PACKAGES
doas apk add -U nfs-utils --quiet

### ENABLE BOOT START
doas rc-update add nfsmount boot >/dev/null 2>&1

### START SERVICE
doas rc-service nfsmount start >/dev/null 2>&1
