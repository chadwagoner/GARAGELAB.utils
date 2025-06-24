#!/bin/sh

### GLOBAL VARIABLES
service='pocket-id'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty
read -p 'APP URL [REQUIRED]: ' app_url < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}

### VALIDATE REQUIRED VARIABLES
if [[ -z $app_url ]]; then
  echo "ERROR: APP URL REQUIRED... Exiting"
  exit 1
fi

### MAKE POCKET-ID DIRECTORY
mkdir -p $service_path/$service
mkdir -p $service_path/$service/data

### CREATE .ENV
cat > $service_path/$service/.env <<EOF
ANALYTICS_DISABLED: true
APP_URL: $app_url
PGID: 1000
PUID: 1000
SERVICE: $service
SERVICE_PATH: $service_path
TRUST_PROXY: true
EOF

### GET COMPOSE FILE
curl -sL -o $service_path/$service/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/$service/compose.yaml

### START POCKET-ID
docker compose -f $service_path/$service/compose.yaml up -d
