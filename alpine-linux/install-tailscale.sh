#!/bin/sh

### INSTALL TAILSCALE
doas apk add -U tailscale@edge-community --quiet

### ENABLE BOOT START
doas rc-update add tailscale default >/dev/null 2>&1

### START SERVICE
doas rc-service tailscale start >/dev/null 2>&1
