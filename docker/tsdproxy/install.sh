#!/bin/sh

### GLOBAL VARIABLES
service='tsdproxy'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty
read -p 'TAILSCALE OAUTH ID [OPTIONAL]: ' tailscale_oauth_id < /dev/tty
read -p 'TAILSCALE OAUTH SECRET [OPTIONAL]: ' tailscale_oauth_secret < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}

### VALIDATE REQUIRED VARIABLES
### NOTE: supposedly no authkey uses OAuth, testing before removing completely
# if [[ -z $tailscale_authkey ]]; then
#   echo "ERROR: TAILSCALE AUTHKEY REQUIRED... Exiting"
#   exit 1
# fi

### MAKE TSDPROXY DIRECTORY
mkdir -p $service_path/$service
mkdir -p $service_path/$service/config
mkdir -p $service_path/$service/data

### CREATE .ENV
cat > $service_path/$service/.env <<EOF
SERVICE: $service
SERVICE_PATH: $service_path
EOF

### CREATE TSDPROXY.CONF
cat > $service_path/$service/config/tsdproxy.yaml <<EOF
defaultProxyProvider: default
docker:
  local:
    host: unix:///var/run/docker.sock
    targetHostname: host.docker.internal
    defaultProxyProvider: default
tailscale:
  providers:
    default:
      clientId: "$tailscale_oauth_id"
      clientSecret: "$tailscale_oauth_secret"
      authKey: ""
      authKeyFile: ""
      tags: "tag:proxy"
      controlUrl: https://controlplane.tailscale.com
  dataDir: /data/
http:
  hostname: 0.0.0.0
  port: 8080
log:
  level: info
  json: false
proxyAccessLog: true
EOF

### GET COMPOSE FILE
curl -sL -o $service_path/$service/compose.yaml -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/$service/compose.yaml

### START SERVICE
docker compose -f $service_path/$service/compose.yaml up -d
