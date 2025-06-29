#!/bin/sh

### INSTALL INTEL CPU PACKAGES
doas apk add -U intel-ucode --quiet

### INSTALL INTEL GPU PACKAGES
doas apk add -U intel-media-driver mesa-dri-gallium --quiet
