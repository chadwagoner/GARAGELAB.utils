#!/bin/sh

### INSTALL PATCHWORK
doas curl -sL -o /etc/periodic/monthly/patchwork -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/templates/periodic/monthly/patchwork
doas chmod 755 /etc/periodic/monthly/patchwork