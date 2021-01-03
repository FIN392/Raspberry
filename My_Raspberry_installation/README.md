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
	- USB wifi dongle (only if your Raspberry model do not include wireless connectivity.
	- SSID and password (later referred to as *[WIFI_SSID]* and *[WIFI_Password]*).
	- One additional static local IP address (later referred to as *[IP_WLAN]*).

## My hardware

I use the following hardware, so other options might involve slight differences:

- [Raspberry Pi 2 Model B Rev 1.1](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)  
- [TP-Link USB WiFi Adapter TL-WN725N](https://www.tp-link.com/us/home-networking/usb-adapter/tl-wn725n/)

## Steps

1. [Burn Raspberry Pi OS to SD card](#sd).
2. [First startup and configuration](#startup).
3. [OS update and base software installation](#update)
4. [Setup LAN connection](#lan)
5. [Setup WiFi connection](#wifi)
6. [Reboot and checks](#checks)

## <a name="sd"></a>Burn Raspberry Pi OS to SD card

*(From computer)*

Download and install [Raspberry Pi Imager](https://www.raspberrypi.org/software/).

Insert the SD into a card reader.

Launch Raspberry Pi Imager.

Choose SD card and choose OS '*Raspberry Pi OS (32-bit)*'.

Click on '*WRITE*'.

## <a name="startup"></a>First startup and configuration

*(From the Raspberry Pi)*

Connect a HMDI monitor, keyboard, mouse and LAN cable to the Raspberry Pi.

Insert the SD card and turn Raspberry Pi on.

Take note of the IP address displayed in the bottom right corner of the '*Welcome to Raspberry Pi*' window ((later referred to as *[DHCP_address]*).

Set country config as follow:
- Country: Spain
- Language: European Spanish
- Timezone: Madrid
- Use English language: Yes
- Use US keyboard: No

Change password for the '*pi*' user account.

Check '*This screen shows a black border around the desktop*' if required.

Skip the '*Select WiFi Network*' window.

Skip the '*Update Software*' window.

Click on '*Restart*'.

Once started, launch '*Raspberry Pi Configuration*' from the menu '*Preferences*'.

In tab '*Interfaces*', check '*Enable*' for '*SSH*'.

*(From computer)*

Access via SSH: ```ssh pi@[DHCP_address]```
* '*[DHCP_address]*' is the IP address from of the '*Welcome to Raspberry Pi*' window
* In Windows, if the message '*WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!*' is shown then delete file '*C:\Users\%USERNAME%\.ssh\known_hosts*'

## <a name="update"></a>OS update and base software installation

xxx ...

## <a name="lan"></a>Setup LAN connection

xxx ...

## <a name="wifi"></a>Setup WiFi connection

xxx ...

## <a name="checks"></a>Reboot and checks

xxx ...
