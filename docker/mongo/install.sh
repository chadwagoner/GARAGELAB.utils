#!/bin/bash

### GLOBAL VARIABLES
service='mongo'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty
read -p 'MONGO USERNAME [mongo]: ' mongo_username < /dev/tty
read -p 'MONGO PASSWORD [changeme123]: ' mongo_password < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}
mongo_username=${mongo_username:-'mongo'}
mongo_password=${mongo_password:-'changeme123'}

### MAKE MONGO DIRECTORY
mkdir -p $service_path/$service
mkdir -p $service_path/$service/data

### CREATE .ENV
echo -e "SERVICE: \"$service\"\nSERVICE_PATH: \"$service_path\"\nMONGO_USERNAME: \"$mongo_username\"\nMONGO_PASSWORD: \"$mongo_password\"" | tee $service_path/$service/.env >/dev/null

### GET COMPOSE FILE
curl -sL -o $service_path/$service/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/$service/compose.yaml

### START MONGO
docker compose -f $service_path/$service/compose.yaml up -d
