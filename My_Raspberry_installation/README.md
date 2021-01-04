![Logo](https://github.com/FIN392/Raspberry/raw/main/images/Raspberry-Logo.png)

# My Raspberry installation:<br>How I install my Raspberry Pi?

The goal is to do the installation of a Raspberry Pi step by step.

Please, send me your comments, critics, doubts, requests or sues.

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
- A computer (Windows, MacOS or Linux) will be required for the SD card preparation.

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
6. [Reboot, checks and backup](#checks).

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

Once started, launch '*Raspberry Pi Configuration*' from the menu '*Preferences*'.

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
		- '*WiFi Country*': '*ES*'.

Reboot once again.

>**NOTE: From now on the monitor, keyboard and mouse connected to the Raspberry will not be necessary.**

## <a name="update"></a>OS update and base software installation

*(From a SSH remote connection)*

```
sudo apt install rpi-update
sudo apt autoremove
sudo apt upgrade
sudo apt update
sudo apt full-upgrade

sudo apt install xrdp # Software required for RDP access

sudo apt install samba samba-common -y # Software required for access via file browser (Explorer, Finder or Nautilus)
# Select 'NO' to modify 'smb.conf'

sudo nano /etc/samba/smb.conf

    # Add to the end of the file

    [pi]
    comment = pi folder
    path = /home/pi
    browseable = Yes
    writeable = Yes
    only guest = no
    create mask = 0777
    directory mask = 0777
    public = no

sudo smbpasswd -a pi
# Type twice password for 'pi'

sudo service smbd restart
```

Check the RDP and SMB connections from a computer.

## <a name="lan"></a>Setup LAN connection

*(From a SSH remote connection)*

```
sudo nano /etc/dhcpcd.conf

    # Add to the end of the file

    interface eth0
    static ip_address=[IP_LAN]/[Mask_bits]
    static routers=[IP_Gateway]
    static domain_name_servers=1.1.1.1

sudo nano /etc/resolv.conf

    # Replace all content with this line

    nameserver 1.1.1.1
```

## <a name="wifi"></a>Setup WiFi connection

>**NOTE: This step might be different if you are using another USB WiFi dongle or the internal wireless interface.**

*(From a SSH remote connection)*

```
sudo wget http://downloads.fars-robotics.net/wifi-drivers/install-wifi -O /usr/bin/install-wifi
sudo chmod +x /usr/bin/install-wifi
sudo install-wifi

sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

    # Replace all content with these lines
    
    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    #ap_scan=1
    update_config=1
    country=ES

wpa_passphrase "[WIFI_SSID]" "[WIFI_Password]" | grep -v "#psk=" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf

sudo nano /etc/dhcpcd.conf

    # Add to the end of the file

    interface wlan0
    static ip_address=[IP_WLAN]/[Mask_bits]
    static routers=[IP_Gateway]
    static domain_name_servers=1.1.1.1
```

## <a name="checks"></a>Reboot, checks and backup

*(From a SSH remote connection)*

```
sudo reboot
```

Once started again, disconnect the LAN cable and check the SSH and RDP accesses.

---
