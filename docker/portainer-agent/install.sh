#!/bin/bash

### USER INPUT VARIABLES
read -p 'SERVICE PATH: ' service_path < /dev/tty
read -p 'DEFAULT DOCKER VOLUME PATH: ' docker_volume_path < /dev/tty

### MAKE PORTAINER-AGENT DIRECTORY
mkdir -p $service_path/portainer-agent

### CREATE .ENV FOR DOCKER VOLUME PATH
echo -e "VOLUME_PATH: \"$docker_volume_path\"" | tee $service_path/portainer-agent/.env >/dev/null

### GET COMPOSE FILE
curl -sL -o $service_path/portainer-agent/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/portainer-agent/compose.yaml

### START PORTAINER-AGENT
docker compose -f $service_path/portainer-agent/compose.yaml up -d