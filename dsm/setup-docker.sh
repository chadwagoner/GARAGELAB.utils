#!/bin/bash

### CREATE DEFAULT DOCKER NETWORKS
docker network create db >/dev/null 2>&1
docker network create internal >/dev/null 2>&1
docker network create management >/dev/null 2>&1
docker network create proxy >/dev/null 2>&1
