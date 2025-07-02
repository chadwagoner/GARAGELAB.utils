#!/bin/sh

### GLOBAL VARIABLES
service='komodo'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty
read -p 'MONGO USERNAME [mongo]: ' mongo_username < /dev/tty
read -p 'MONGO PASSWORD [changeme123]: ' mongo_password < /dev/tty
read -p 'APP URL [REQUIRED]: ' app_url < /dev/tty
read -p 'ENABLE OIDC [OPTIONAL] (default: false): ' oidc_enable < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}
mongo_username=${mongo_username:-'mongo'}
mongo_password=${mongo_password:-'changeme123'}
oidc_enable=${oidc_enable:-false}

### OIDC VARIABLES
if [[ $oidc_enable == true ]]; then
  read -p 'OIDC PROVIDER URL: ' oidc_provider < /dev/tty
  read -p 'OIDC CLIENT ID: ' oidc_client_id < /dev/tty
  read -p 'OIDC CLIENT SECRET: ' oidc_client_secret < /dev/tty
  read -p 'OIDC USE FULL EMAIL (default: false): ' oidc_use_email < /dev/tty

  oidc_use_email=${oidc_use_email:-'false'}
fi

### VALIDATE REQUIRED VARIABLES
if [[ -z $app_url ]]; then
  echo "ERROR: APP URL REQUIRED... Exiting"
  exit 1
fi

### MAKE KOMODO DIRECTORY
mkdir -p $service_path/$service
mkdir -p $service_path/$service/core
mkdir -p $service_path/$service/core/repo-cache
mkdir -p $service_path/$service/core/syncs
mkdir -p $service_path/$service/mongo
mkdir -p $service_path/$service/mongo/data
mkdir -p $service_path/$service/mongo/config

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
KOMODO_MONITORING_INTERVAL: "15-sec"
KOMODO_PASSKEY: "a_random_passkey"
KOMODO_RESOURCE_POLL_INTERVAL: "1-hr"
KOMODO_TITLE: "Komodo"
KOMODO_TRANSPARENT_MODE: false
KOMODO_WEBHOOK_SECRET: "a_random_secret"
SERVICE: $service
SERVICE_PATH: $service_path
EOF

### INJECT AUTH VARIABLES BASED ON OIDC
if [[ $oidc_enable == true ]]; then
  cat >> $service_path/$service/.env <<EOF
KOMODO_LOCAL_AUTH: false
KOMODO_OIDC_ENABLED: $oidc_enable
KOMODO_OIDC_PROVIDER: $oidc_provider
KOMODO_OIDC_CLIENT_ID: $oidc_client_id
KOMODO_OIDC_CLIENT_SECRET: $oidc_client_secret
KOMODO_OIDC_USE_FULL_EMAIL: $oidc_use_email
EOF
else
  cat >> $service_path/$service/.env <<EOF
KOMODO_LOCAL_AUTH: true
KOMODO_OIDC_ENABLED: $oidc_enable
EOF
fi

### GET COMPOSE FILE
curl -sL -o $service_path/$service/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/$service/compose.yaml

### START SERVICE
docker compose -f $service_path/$service/compose.yaml up -d
