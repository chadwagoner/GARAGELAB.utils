#!/bin/sh

### MAKE PORTAINER DIRECTORY
mkdir -p /opt/services/portainer/data

### GET COMPOSE FILE
curl -sL -o /opt/services/portainer/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/portainer/compose.yaml

### START PORTAINER
docker compose -f /opt/services/portainer/compose.yaml up -d