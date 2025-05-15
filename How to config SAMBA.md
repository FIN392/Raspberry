# How to config SAMBA

```
sudo -i
```

## Install
```
apt install samba samba-common-bin -y
```

## Create folder

```bash
mkdir -p /home/master/samba
chown -R master:master /home/master/samba
```

## Create user

```bash
smbpasswd -a master
```

## Config
```bash
sudo nano /etc/samba/smb.conf
```

```bash
[samba]
   path = /home/master/samba
   browseable = yes
   writeable = yes
   valid users = master
   create mask = 0775
   directory mask = 0775
   public = no
```


## Restart SAMBA

```bash
systemctl restart smbd
```

## On Windows

```batch
NET USE S: \\192.168.1.10\samba /USER:master *
```


```bash
# Reiniciar el servicio Samba
sudo systemctl restart smbd && echo "Samba reiniciado"

#!/bin/bash
service="smbd"
echo "Reiniciando $service..."
sudo systemctl restart "$service"

```