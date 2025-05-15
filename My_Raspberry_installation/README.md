![Logo](https://github.com/FIN392/Raspberry/raw/main/images/Raspberry-Logo.png)

# Proceso de instalación de mi Raspberry Pi
*(Actualizado en mayo de 2025)*

Esto es una guía paso a paso para la instalación de **mi** Raspberry Pi.

Estos son los pasos son para mi propio hardware, por lo que podrían ser ligeramente diferentes en tu caso.

## Requerimientos

- Una Raspberry Pi.
- Una tarjeta SD.
- Acceso a Internet.
- Un ordenador Windows.

## ¿Que hardware tengo yo?

- [Raspberry Pi 2 Model B Rev 1.1](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)
- [TP-Link USB WiFi Adapter TL-WN725N](https://www.tp-link.com/us/home-networking/usb-adapter/tl-wn725n/)

El adaptador USB Wifi no es necesario, tambien se puede conectar un cable de red de la Raspberry al router de casa.

## Pasos

1. [Grabar la tarjeta SD con el SO de Raspberry Pi](#sd).
2. [Primer inicio](#startup).
3. [Actualización y configuración](#update).
4. [Reinicio y pruebas](#checks).
5. [Copia de seguridad](#backup).

## <a name="sd"></a>Grabar la tarjeta SD con el SO de Raspberry Pi

*(En un ordenador Windows)*

Descargar el programa [Raspberry Pi Imager](https://www.raspberrypi.org/software/).

Ejecutar el programa para instalarlo y al final ejecutarlo.

![image](https://github.com/user-attachments/assets/0b838105-b0f3-4ca7-88e8-67f970ec647d)

Pulsar en '*ELEGIR DISPOSITIVO*' y seleccionar '*Raspberry Pi 2 - Model B*'.

Pulsar en '*ELEGIR SO*' y seleccionar '*Raspberry Pi OS (other)*' y luego '*Raspberry Pi OS Lite (32-bit)*'.

Pulsar en '*ELEGIR ALMACENAMIENTO*' y seleccionar la tarjeta SD.

Pulsar en '*SIGUIENTE*'

![image](https://github.com/user-attachments/assets/74c9a23f-77b3-4ad4-a96e-8477d89f9d75)

Pulsar en '*EDITAR AJUSTES*'.

Configurar '*GENERAL*', '*SERVICIOS*' y '*OPCIONES*' de la siguiente forma:

- *Nombre de anfitrión*: Nombre que tendrá tu Raspberry.
- *Nombre de usuario*: Nombre del usuario por defecto. Tradicionalmente era '*pi*' pero es más seguro cambiarlo.
- *Contrasñea*: Contraseña del usuario por defecto. Será usada para elevar permisos '*su*'.
- *SSID*: Nombre de la red Wifi.
- *Contrasñea*: Contraseña de la red Wifi.

![image](https://github.com/user-attachments/assets/37be67b7-15c7-4d96-9a6e-3e5206457a72)
![image](https://github.com/user-attachments/assets/357e038b-c6a9-4c8f-b581-4dd317207d3f)
![image](https://github.com/user-attachments/assets/3a77cfdf-f0e3-439f-97a3-80b63086fe27)

Pulsar en '*GUARDAR*'.

![image](https://github.com/user-attachments/assets/3c3186d8-9870-4b16-abef-a61ca13fe465)

Pular en '*SÍ*'.

![image](https://github.com/user-attachments/assets/e21b6d1a-9513-4e2b-b23c-3d12a3cebbdb)

Pulsar en '*SÍ*'.

Tras unos minutos el proceso de generación de la tarjeta SD termina.

![image](https://github.com/user-attachments/assets/409ea692-c2f3-4ac5-86e1-db9cfb3f11b9)

Pulsar en '*CONTINUAR*' y sacar la tarjeta SD del lector.

------------

## <a name="startup"></a>Primer inicio

*(En la Raspberry Pi)*

Concetar un monitor al puerto HMDI de la Raspberry Pi, insertar la tarjeta SD y encender.

Tras varios minutos y reinicios se mostrará algo similar a esto:

```
Raspbian GNU/Linux 12 FIN392PI tty1
My IP address in 192.168.1.20 fe80:ef73:d389:f130:5526
FIN392PI login: _
```

Anotar la dirección IP y retirar el cable HDMI de la Raspbery Pi. 

A partir de este momento el acceso a la Raspberry Pi se realizará desde un cliente SSH.

*(En un ordenador Windows)*

Ejecute el cliente SSH con el siguiente comando desde una ventana de símbolo del sistema (*CMD*):

```
C:\> ssh.exe 192.168.1.20 -l master
```

La IP debe ser la mostrada por pantalla en el primer inicio y el usuario (*master*) debe ser el elegido en la creación de la SD.

Si se muestra el siguiente mensaje...

``` 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25159 key sent by the remote host is
SHA256:MFKJ/n8PpDzevg3hmTvr+NFAjE32xn7K4LFW8zXPMTC.
Please contact your system administrator.
Add correct host key in C:\\Users\\fin392/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in C:\\Users\\fin392/.ssh/known_hosts:3
Host key for 192.168.1.20 has changed and you have requested strict checking.
Host key verification failed.
```

Se debe eliminar el siguiente fichero:

```
C:\>del  C:\Users\fin392\.ssh\known_hosts
```

Si se muestra el siguiente mensaje...

```
The authenticity of host '192.168.1.20 (192.168.1.20)' can't be established.
ED25159 key fingerprint is SHA256:MFKJ/n8PpDzevg3hmTvr+NFAjE32xn7K4LFW8zXPMTC.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Contestar con '*yes*'

Si se muestra este mensaje:

```
master@192.168.1.20's password:
Linux FIN392PI 6.12.25+rpt-rpi-v7 #1 SMP Raspbian 1:6.12.25-1+rpt1 (2025-04-30) armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
master@FIN392PI:~ $
```

Enhorabuena, ya esta dentro de su Raspberry Pi. Ahora necesitara hacer algunas cofiguraciones:

###






Connect a HMDI monitor, keyboard, mouse and LAN cable to the Raspberry Pi.

Insert the SD card and turn the Raspberry Pi on.



------------------------------------


Take note of the IP address displayed in the bottom right corner of the '*Welcome to Raspberry Pi*' window (later referred to as *[DHCP_address]*).

Follow the initial configuration windows and choose 'Restart' at the end.

Once started, launch '*Raspberry Pi Configuration*' from the menu '*Preferences*', and set values as follow:

- Tab '*System*':
	- Click on '*Change Password...*' and change the password for user '*pi*' (it is more secure).
	- Change '*Hostname*' (For example, 'RB1').
	- Keep '*Boot*' as '*To Desktop*' (CLI is only for geeks ;-D).
	- Change '*Auto login*' to '*Disabled*' (it is more secure).
	- Keep '*Network at Boot*' as '*Do not wait*' (better when network fail).
	- Keep '*Splash Screen*' as '*Enable*' (just because I like it).
- Tab 'Interfaces':
	- Set '*SSH*' as '*Enable*'. I hate to have HMDI monitor, keyboard y mouse cables conneted, so I work using SSH and RDP.
- Tab 'Location':
	- Check and/or change '*Locale*', '*Timezone*', '*Keyboard*' and '*WiFi Country*'. This are my options:
		- '*Locale*': '*en (English)*' / '*US (United States)*' / '*UTF-8*'.
		- '*Timezone*': '*Europe*' / '*Madrid*'.
		- '*Keyboard*': '*Dell USB Multimedia*' / '*Spanish*' / '*Spanish (Win keys)*'.
		- '*WiFi Country*': '*ES Spain*'.

Reboot once again.

>**NOTE: From now on the monitor, keyboard and mouse connected to the Raspberry will not be necessary.**

## <a name="update"></a>OS update and base software installation

Connect with the Raspberry using SSH and the IP address [DHCP_address].

```
# Everything is easier as ROOT ('I AM gROOT')
sudo -i

# Upgrade and update everything (takes 15-20 minutes approx.)
apt install rpi-update -y
apt autoremove -y
apt upgrade -y
apt update -y
apt full-upgrade -y

# Install XRDP. Required for RDP access
apt install xrdp -y

# Install SAMBA. Required for access via file browser (Explorer, Finder or Nautilus)
echo "samba-common samba-common/workgroup string  WORKGROUP" | debconf-set-selections
echo "samba-common samba-common/dhcp boolean true" | debconf-set-selections
echo "samba-common samba-common/do_debconf boolean true" | debconf-set-selections
apt install samba -y

# SAMBA configuration
echo "" >> /etc/samba/smb.conf
echo "########################################" >> /etc/samba/smb.conf
echo "#" >> /etc/samba/smb.conf
echo "# Share definition for '/home/pi'" >> /etc/samba/smb.conf
echo "#" >> /etc/samba/smb.conf
echo "# $(date)" >> /etc/samba/smb.conf
echo "#" >> /etc/samba/smb.conf
echo "[pi]" >> /etc/samba/smb.conf
echo "   comment = pi folder" >> /etc/samba/smb.conf
echo "   path = /home/pi" >> /etc/samba/smb.conf
echo "   browseable = Yes" >> /etc/samba/smb.conf
echo "   writeable = Yes" >> /etc/samba/smb.conf
echo "   only guest = no" >> /etc/samba/smb.conf
echo "   create mask = 0777" >> /etc/samba/smb.conf
echo "   directory mask = 0777" >> /etc/samba/smb.conf
echo "   public = no" >> /etc/samba/smb.conf
echo "#" >> /etc/samba/smb.conf
echo "########################################" >> /etc/samba/smb.conf
echo "" >> /etc/samba/smb.conf

# User pi to SAMBA users list
smbpasswd -a pi
# Type twice password for 'pi'

# Restart SAMBA
service smbd restart

# Exit from sudo
exit
```

Check the RDP and SMB connections from a computer with the IP [DHCP_address].

## <a name="lan"></a>Setup LAN connection

*(From a SSH remote connection)*

```
# Everything is easier as ROOT ('I AM gROOT')
sudo -i

# ATTENTION!! Before copy&paste this section, replace [variable] by their value
IP_LAN=[IP_LAN]         # e.g., 192.168.1.10
Mask_bits=[Mask_bits]   # e.g., 24
IP_Gateway=[IP_Gateway] # e.g., 192.168.1.1

# Static IP configuration for 'eth0'
echo "" >> /etc/dhcpcd.conf
echo "########################################" >> /etc/dhcpcd.conf
echo "#" >> /etc/dhcpcd.conf
echo "# Static IP configuration for 'eth0'" >> /etc/dhcpcd.conf
echo "#" >> /etc/dhcpcd.conf
echo "# $(date)" >> /etc/dhcpcd.conf
echo "#" >> /etc/dhcpcd.conf
echo "interface eth0" >> /etc/dhcpcd.conf
echo "static ip_address=$IP_LAN/$Mask_bits" >> /etc/dhcpcd.conf
echo "static routers=$IP_Gateway" >> /etc/dhcpcd.conf
echo "static domain_name_servers=1.1.1.1" >> /etc/dhcpcd.conf
echo "#" >> /etc/samba/dhcpcd.conf
echo "########################################" >> /etc/dhcpcd.conf
echo "" >> /etc/dhcpcd.conf

# Set 1.1.1.1 (Cloudflare) as DNS
rm /etc/resolv.conf
echo "" >> /etc/resolv.conf
echo "########################################" >> /etc/resolv.conf
echo "#" >> /etc/resolv.conf
echo "# Set 1.1.1.1 (Cloudflare) as DNS" >> /etc/resolv.conf
echo "#" >> /etc/resolv.conf
echo "# $(date)" >> /etc/resolv.conf
echo "#" >> /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
echo "#" >> /etc/samba/resolv.conf
echo "########################################" >> /etc/resolv.conf
echo "" >> /etc/resolv.conf

# Exit from sudo
exit
```

## <a name="wifi"></a>Setup WiFi connection

>**NOTE: This step might be different if you are using another USB WiFi dongle or the internal wireless interface.**

*(From a SSH remote connection)*

```
# Everything is easier as ROOT ('I AM gROOT')
sudo -i

# ATTENTION!! Before copy&paste this section, replace [variable] by their value
IP_WLAN=[IP_WLAN]             # e.g., 192.168.1.11
Mask_bits=[Mask_bits]         # e.g., 24
IP_Gateway=[IP_Gateway]       # e.g., 192.168.1.1
WIFI_SSID=[WIFI_SSID]         # e.g., WLAN_FABADA
WIFI_Password=[WIFI_Password] # e.g., SecretP@ssw0rd

# Install driver for TP-Link USB WiFi Adapter TL-WN725N
wget http://downloads.fars-robotics.net/wifi-drivers/install-wifi -O /usr/bin/install-wifi
chmod +x /usr/bin/install-wifi
install-wifi

# Wireless configuration
rm /etc/wpa_supplicant/wpa_supplicant.conf
echo "" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "########################################" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "#" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "# Wireless configuration" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "#" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "# $(date)" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "#" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "country=ES" >> /etc/wpa_supplicant/wpa_supplicant.conf
wpa_passphrase "$WIFI_SSID" "$WIFI_Password" | grep -v "#psk=" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "#" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "########################################" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "" >> /etc/wpa_supplicant/wpa_supplicant.conf

# Static IP configuration for 'wlan0'
echo "" >> /etc/dhcpcd.conf
echo "########################################" >> /etc/dhcpcd.conf
echo "#" >> /etc/dhcpcd.conf
echo "# Static IP configuration for 'wlan0'" >> /etc/dhcpcd.conf
echo "#" >> /etc/dhcpcd.conf
echo "# $(date)" >> /etc/dhcpcd.conf
echo "#" >> /etc/dhcpcd.conf
echo "interface wlan0" >> /etc/dhcpcd.conf
echo "static ip_address=$IP_WLAN/$Mask_bits" >> /etc/dhcpcd.conf
echo "static routers=$IP_Gateway" >> /etc/dhcpcd.conf
echo "static domain_name_servers=1.1.1.1" >> /etc/dhcpcd.conf
echo "#" >> /etc/samba/dhcpcd.conf
echo "########################################" >> /etc/dhcpcd.conf
echo "" >> /etc/dhcpcd.conf

# Exit from sudo
exit
```

## <a name="checks"></a>Reboot, checks and backup

*(From a SSH remote connection)*

```
sudo reboot
```

Once started again, check the SSH and RDP accesses with the IP [IP_LAN], and then unplug the LAN cable and check again with the IP [IP_WLAN].

## <a name="backup"></a>Backup and periodic update

I highly recommend making an image of the SD card. 'Win32 Disk Imager' is a great option for this, so take a look at its official website [win32diskimager.org](https://win32diskimager.org/).

My second extremely high recommendation is to update and upgrade everything from time to time (I mean at least twice a year, not twice for life).

How? '*This is the way*'.

```
# Everything is easier as ROOT ('I AM gROOT')
sudo -i

# Upgrade and update everything (takes 15-20 minutes approx.)
apt install rpi-update -y
apt autoremove -y
apt upgrade -y
apt update -y
apt full-upgrade -y
```

'*That's all folks!*' Please, send me your comments, critics, doubts, requests or sues.

---
