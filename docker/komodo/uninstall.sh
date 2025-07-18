#!/bin/sh

### GLOBAL VARIABLES
service='komodo'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}

### STOP SERVICE
docker compose -f $service_path/$service/compose.yaml down --rmi all --volumes

### REMOVE SERVICE FILES/DIRECTORIES
doas rm -rf $service_path/$service
