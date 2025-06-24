#!/bin/sh

### GLOBAL VARIABLES
service='pocket-id'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}

### MAKE POCKET-ID DIRECTORY
mkdir -p $service_path/$service
mkdir -p $service_path/$service/data

### CREATE .ENV
cat > $service_path/$service/.env <<EOF
APP_URL: https://pocket-id.unicorn-stargazer.ts.net
TRUST_PROXY: true
PUID: 1000
PGID: 1000
ANALYTICS_DISABLED: true
EOF

### GET COMPOSE FILE
curl -sL -o $service_path/$service/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/$service/compose.yaml

### START POCKET-ID
docker compose -f $service_path/$service/compose.yaml up -d
