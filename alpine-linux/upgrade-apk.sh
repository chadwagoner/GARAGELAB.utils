#!/bin/sh

### SET APK REPOSITORIES
doas curl -sL -o /etc/apk/repositories -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/templates/apk/repositories

### UPDATE OS
doas apk upgrade -U --quiet

### SLEEP
sleep 60

### REBOOT
doas reboot
