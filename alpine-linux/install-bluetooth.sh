#!/bin/sh

### INSTALL BLUEZ
doas apk add -U bluez --quiet

### ENABLE BOOT START
doas rc-update add bluetooth default >/dev/null 2>&1

### START SERVICE
doas rc-service bluetooth start >/dev/null 2>&1

### ADD LP GROUP TO USER
doas addgroup alpine lp

### SLEEP TO ALLOW DOCKER TO START
sleep 3
