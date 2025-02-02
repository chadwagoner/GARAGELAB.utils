#!/bin/sh

### MAKE SEMAPHORE DIRECTORY
mkdir -p /opt/services/semaphore
mkdir -p /opt/services/semaphore/config
mkdir -p /opt/services/semaphore/data

### SET PERMISSIONS FOR SEMAPHORE USER
doas chown 1001:1001 /opt/services/semaphore/config
doas chown 1001:1001 /opt/services/semaphore/data

### GET COMPOSE FILE
curl -sL -o /opt/services/semaphore/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/semaphore/compose.yaml

### START SEMAPHORE
docker compose -f /opt/services/semaphore/compose.yaml up -d