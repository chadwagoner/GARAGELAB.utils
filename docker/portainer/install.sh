#!/bin/sh

### MAKE SERVICE DIRECTORY
mkdir -p /opt/services/portainer
mkdir -p /opt/services/portainer/data

### GET COMPOSE FILE
curl -sL -o /opt/services/portainer/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/portainer/compose.yaml

### START SERVICE
docker compose -f /opt/services/portainer/compose.yaml up -d