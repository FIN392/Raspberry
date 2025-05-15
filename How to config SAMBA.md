# How to config SAMBA

```
sudo -i
```

## Install
```
apt install samba samba-common-bin -y
```

## Create folder

```sh
mkdir -p /home/master/samba
chown -R master:master /home/master/samba
```

## Create user

```sh
smbpasswd -a master
```

## Config
```sh
sudo nano /etc/samba/smb.conf
```

```sh
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

```sh
systemctl restart smbd
```

## On Windows

```Batch
NET USE S: \\192.168.1.10\samba /USER:master *
```
