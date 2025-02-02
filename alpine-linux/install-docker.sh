#!/bin/sh

### INSTALL DOCKER
doas apk add -U docker docker-cli-compose --quiet

### ENABLE BOOT START
doas rc-update add docker default

### START SERVICE
doas rc-service docker start

### ADD DOCKER GROUP TO USER
doas addgroup alpine docker

### SLEEP TO ALLOW DOCKER TO START
sleep 10

### CREATE DEFAULT DOCKER NETWORKS
doas docker network create db
doas docker network create management
doas docker network create proxy

### CREATE DEFAULT SERVICE DIRECTORY
doas mkdir -p /opt/services
doas chown alpine:alpine /opt/services