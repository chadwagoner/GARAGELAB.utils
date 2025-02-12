#!/bin/bash

### USER INPUT VARIABLES
read -p 'SERVICE PATH: ' service_path < /dev/tty
read -p 'MONGO USERNAME: ' mongo_username < /dev/tty
read -p 'MONGO PASSWORD: ' mongo_password < /dev/tty

### MAKE MONGODB DIRECTORY
mkdir -p $service_path/mongo
mkdir -p $service_path/mongo/data

### CREATE .ENV
echo -e "SERVICE_PATH: \"$service_path\"\nMONGO_USERNAME: \"$mongo_username\"\nMONGO_PASSWORD: \"$mongo_password\"" | tee $service_path/mongo/.env >/dev/null

### GET COMPOSE FILE
curl -sL -o $service_path/mongo/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/mongo/compose.yaml

### START MONGO
docker compose -f $service_path/mongo/compose.yaml up -d