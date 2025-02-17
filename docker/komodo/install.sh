#!/bin/bash

### USER INPUT VARIABLES
read -p 'SERVICE PATH: ' service_path < /dev/tty
read -p 'MONGO USERNAME: ' mongo_username < /dev/tty
read -p 'MONGO PASSWORD: ' mongo_password < /dev/tty

### MAKE KOMODO DIRECTORY
mkdir -p $service_path/komodo
mkdir -p $service_path/komodo/data

### CREATE .ENV
echo -e "SERVICE_PATH: \"$service_path\"\nMONGO_USERNAME: \"$mongo_username\"\nMONGO_PASSWORD: \"$mongo_password\"\nKOMODO_TITLE: \"Komodo\"\nKOMODO_FIRST_SERVER: \"https://periphery:8120\"\nKOMODO_DISABLE_CONFIRM_DIALOG: false\nKOMODO_PASSKEY: \"a_random_passkey\"\nKOMODO_MONITORING_INTERVAL: \"15-sec\"\nKOMODO_RESOURCE_POLL_INTERVAL: \"5-min\"\nKOMODO_WEBHOOK_SECRET: \"a_random_secret\"\nKOMODO_JWT_SECRET: \"a_random_jwt_secret\"\nKOMODO_LOCAL_AUTH: true\nKOMODO_DISABLE_USER_REGISTRATION: false\nKOMODO_ENABLE_NEW_USERS: false\nKOMODO_DISABLE_NON_ADMIN_CREATE: false\nKOMODO_TRANSPARENT_MODE: false\nKOMODO_JWT_TTL: \"1-day\"\nKOMODO_OIDC_ENABLED: false\nKOMODO_GITHUB_OAUTH_ENABLED: false\nKOMODO_GOOGLE_OAUTH_ENABLED: false\nPERIPHERY_PASSKEYS: \"${KOMODO_PASSKEY}\"\nPERIPHERY_ROOT_DIRECTORY: \"${SERVICE_PATH}/komodo/data\"\nPERIPHERY_SSL_ENABLED: true\nPERIPHERY_INCLUDE_DISK_MOUNTS: \"/etc/hostname\"" | tee $service_path/komodo/.env >/dev/null

### GET COMPOSE FILE
curl -sL -o $service_path/komodo/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/komodo/compose.yaml

### START KOMODO
docker compose -f $service_path/komodo/compose.yaml up -d