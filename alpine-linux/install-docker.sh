#!/bin/sh

### INSTALL DOCKER
doas apk add -U docker docker-cli-compose

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
doas docker network create internal
doas docker network create proxy

### CREATE DEFAULT SERVICE LOCATION
doas mkdir -p /opt/services
doas chown alpine:alpine /opt/services