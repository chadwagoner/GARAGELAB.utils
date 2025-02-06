#!/bin/bash

### CREATE DEFAULT DOCKER NETWORKS
docker network create db >/dev/null 2>&1
docker network create internal >/dev/null 2>&1
docker network create management >/dev/null 2>&1
docker network create proxy >/dev/null 2>&1

### INSTALL DOCKER COMPOSE
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod 755 $DOCKER_CONFIG/cli-plugins/docker-compose