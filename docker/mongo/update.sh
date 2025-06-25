#!/bin/sh

### GLOBAL VARIABLES
service='mongo'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}

### GET COMPOSE FILE
curl -sL -o $service_path/$service/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/$service/compose.yaml

### START SERVICE
docker compose -f $service_path/$service/compose.yaml up -d
