![Logo](https://github.com/FIN392/Raspberry/raw/main/images/Raspberry-Logo.png)

# My Raspberry installation:<br>How I install my Raspberry Pi?

The goal is to do the installation of a Raspberry Pi step by step.

Please understand that *this is the way* I do it for the hardware that I have. The idea is that it serves as an example since with your hardware there may be things that needs to be done differently.

## Requirements

- Raspberry Pi.
- SD Card (*4 GB or more*).
- Internet access.
- Home network details:
	- One static local IP address (later referred to as *[IP_LAN]*).
	- Default gateway IP. Typically it is the IP address of the router (later referred to as *[IP_Gateway]*).
	- Network mask bits. Typically is '/24' (later referred to as *[Mask_bits]*).
- If you want to connect wireless, you will need also:
	- USB wifi dongle (only if your Raspberry model do not include wireless connectivity).
	- SSID and password (later referred to as *[WIFI_SSID]* and *[WIFI_Password]*).
	- One additional static local IP address (later referred to as *[IP_WLAN]*).
- A computer (Windows, MacOS or Linux) will be required for the SD card preparation and, optionally, to manage the Raspberry remotely.

## My hardware

I use the following hardware, so other options might involve slight differences:

- [Raspberry Pi 2 Model B Rev 1.1](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)  
- [TP-Link USB WiFi Adapter TL-WN725N](https://www.tp-link.com/us/home-networking/usb-adapter/tl-wn725n/)

## Steps

1. [Burn Raspberry Pi OS to SD card](#sd).
2. [First startup and configuration](#startup).
3. [OS update and base software installation](#update).
4. [Setup LAN connection](#lan).
5. [Setup WiFi connection](#wifi).
6. [Reboot and checks](#checks).
7. [Backup and periodic update](#backup).

## <a name="sd"></a>Burn Raspberry Pi OS to SD card

*(From a computer)*

Download and install [Raspberry Pi Imager](https://www.raspberrypi.org/software/).

Insert the SD into a card reader.

Launch Raspberry Pi Imager.

Click on 'Choose SD card' and select the correct SD card unit.

Click on 'Choose OS' and select '*Raspberry Pi OS (32-bit)*'.

Click on '*WRITE*'.

## <a name="startup"></a>First startup and configuration

*(From the Raspberry Pi)*

Connect a HMDI monitor, keyboard, mouse and LAN cable to the Raspberry Pi.

Insert the SD card and turn Raspberry Pi on.

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
IP_LAN=[IP_LAN]
Mask_bits=[Mask_bits]
IP_Gateway=[IP_Gateway]

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
IP_WLAN=[IP_WLAN]
Mask_bits=[Mask_bits]
IP_Gateway=[IP_Gateway]
WIFI_SSID=[WIFI_SSID]
WIFI_Password=[WIFI_Password]

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

My second extremely high recommendation is to update and update everything from time to time (I mean at least twice a year, not twice for life).

How? '*This is the way*'.

```
# Upgrade and update everything (takes 15-20 minutes approx.)
apt install rpi-update -y
apt autoremove -y
apt upgrade -y
apt update -y
apt full-upgrade -y
```

'*That's all folks!*' Please, send me your comments, critics, doubts, requests or sues.

---
