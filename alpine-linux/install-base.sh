#!/bin/sh

### SET APK REPOSITORIES
doas curl -sL -o /etc/apk/repositories -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/templates/apk/repositories

### SET ROOT CRONTAB
doas curl -sL -o /etc/crontabs/root -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/templates/crontab/root

### DISABLE IPV6 NETWORKING
echo -e "net.ipv6.conf.all.disable_ipv6 = 1" | doas tee /etc/sysctl.d/99-system.conf >/dev/null

### UPDATE OS
doas apk upgrade -U --quiet

### INSTALL BASE PACKAGES
doas apk add -U htop vim --quiet

### RUN SYNC BEFORE REBOOT
doas sync

### REBOOT
doas reboot
