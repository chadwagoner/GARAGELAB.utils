#!/bin/bash

### GLOBAL VARIABLES
service='mongo'

### USER INPUT VARIABLES
read -p 'SERVICE PATH [/opt/services]: ' service_path < /dev/tty

### SET DEFAULT VALUES IF BLANK
service_path=${service_path:-'/opt/services'}

### STOP MONGO
docker compose -f $service_path/$service/compose.yaml down --rmi all --volumes

### REMOVE MONGO SERVICE FILES/DIRECTORIES
rm -rf $service_path/$service
