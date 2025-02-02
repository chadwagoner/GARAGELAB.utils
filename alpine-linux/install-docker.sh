#!/bin/sh

### INSTALL NFS PACKAGES
doas apk add -U docker docker-cli-compose --quiet

### ENABLE BOOT START
doas rc-update add docker default

### START SERVICE
doas rc-service docker start

### ADD DOCKER GROUP TO USER
doas addgroup 1000 docker

### CREATE DEFAULT DOCKER NETWORKS
doas docker network create db
doas docker network create internal
doas docker network create proxy

### CREATE DEFAULT SERVICE LOCATION
doas mkdir -p /opt/services
doas chown 1000:1000 /opt/services