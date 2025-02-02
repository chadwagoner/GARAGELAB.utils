#!/bin/sh

### SET APK REPOSITORIES
doas sed -i '1d' /etc/apk/repositories
doas sed -i 's/#//g' /etc/apk/repositories

### INSTALL BASE PACKAGES
doas apk add -U curl vim