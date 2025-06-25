#!/bin/sh

### GLOBAL VARIABLES
service='komodo'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty
read -p 'MONGO USERNAME [mongo]: ' mongo_username < /dev/tty
read -p 'MONGO PASSWORD [changeme123]: ' mongo_password < /dev/tty
read -p 'APP URL [REQUIRED]: ' app_url < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}
mongo_username=${mongo_username:-'mongo'}
mongo_password=${mongo_password:-'changeme123'}

### VALIDATE REQUIRED VARIABLES
if [[ -z $app_url ]]; then
  echo "ERROR: APP URL REQUIRED... Exiting"
  exit 1
fi

### MAKE KOMODO DIRECTORY
mkdir -p $service_path/$service
mkdir -p $service_path/$service/repo-cache
mkdir -p $service_path/$service/syncs

### CREATE .ENV
cat > $service_path/$service/.env <<EOF
KOMODO_DATABASE_ADDRESS: "mongo:27017"
KOMODO_DATABASE_PASSWORD: $mongo_password
KOMODO_DATABASE_USERNAME: $mongo_username
KOMODO_DISABLE_CONFIRM_DIALOG: false
KOMODO_DISABLE_NON_ADMIN_CREATE: false
KOMODO_DISABLE_USER_REGISTRATION: false
KOMODO_ENABLE_NEW_USERS: false
KOMODO_GITHUB_OAUTH_ENABLED: false
KOMODO_GOOGLE_OAUTH_ENABLED: false
KOMODO_HOST: $app_url
KOMODO_JWT_SECRET: "a_random_jwt_secret"
KOMODO_JWT_TTL: "1-day"
KOMODO_LOCAL_AUTH: true
KOMODO_MONITORING_INTERVAL: "15-sec"
KOMODO_OIDC_ENABLED: false
KOMODO_PASSKEY: "a_random_passkey"
KOMODO_RESOURCE_POLL_INTERVAL: "1-hr"
KOMODO_TITLE: "Komodo"
KOMODO_TRANSPARENT_MODE: false
KOMODO_WEBHOOK_SECRET: "a_random_secret"
SERVICE: $service
SERVICE_PATH: $service_path
EOF

### GET COMPOSE FILE
curl -sL -o $service_path/$service/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/$service/compose.yaml

### START SERVICE
docker compose -f $service_path/$service/compose.yaml up -d
