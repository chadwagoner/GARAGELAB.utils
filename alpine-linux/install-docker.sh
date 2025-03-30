#!/bin/sh

### INSTALL DOCKER
doas apk add -U docker docker-cli-compose --quiet

### ENABLE BOOT START
doas rc-update add docker default >/dev/null 2>&1

### START SERVICE
doas rc-service docker start >/dev/null 2>&1

### ADD DOCKER GROUP TO USER
doas addgroup alpine docker

### SLEEP TO ALLOW DOCKER TO START
sleep 3

### CREATE DEFAULT DOCKER NETWORKS
doas docker network create db >/dev/null 2>&1
doas docker network create internal >/dev/null 2>&1
doas docker network create management >/dev/null 2>&1
doas docker network create proxy >/dev/null 2>&1

### CREATE DEFAULT SERVICE DIRECTORY
doas mkdir -p /opt/services/downloads
doas chown -R alpine:alpine /opt/services
