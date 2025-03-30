#!/bin/sh

### INSTALL QEMU-GUEST-AGENT
doas apk add -U qemu-guest-agent --quiet

### ENABLE BOOT START
doas rc-update add qemu-guest-agent default >/dev/null 2>&1

### ANNOUCEMENT
echo -e "MAKE SURE TO ENABLE QEMU-GUEST-AGENT IN PROXMOX..."

### POWEROFF TO ENABLE QEMU GUEST AGENT ON PROXMOX
doas poweroff
