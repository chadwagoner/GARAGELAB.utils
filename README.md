# GARAGELAB.utils

## ALPINE LINUX

### PRE-REQUISITE

```bash
doas apk add -U curl
```

### INSTALL

#### BASE

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/install-base.sh | sh
```

#### DOCKER

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/install-docker.sh | sh
```

#### DRIVER-INTEL

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/install-driver-intel.sh | sh
```

#### NFS

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/install-nfs.sh | sh
```

### CONFIGURE

#### NFS-BACKUP

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/configure-nfs-backup.sh | sh
```

#### NFS-MEDIA

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/configure-nfs-media.sh | sh
```

### UPGRADE

#### APK

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/alpine-linux/upgrade-apk.sh | sh
```

## SERVICES

### PORTAINER

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/portainer/install.sh | sh
```

### SEMAPHORE

```bash
curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/chadwagoner/GARAGELAB.utils/main/docker/semaphore/install.sh | sh
```