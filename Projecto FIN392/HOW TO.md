# Project RB-FIN392

The goal is to 

- [PHASE I](#PHASE_I): Basic installation of the Raspberry Pi
- [PHASE II](#PHASE_II): Install the '*telegramMonitoring*' scripts
- [PHASE III](#PHASE_III): Install the print service ([CUPS](https://www.cups.org/))
- [PHASE IV](#PHASE_IV): Install the CCTV service ([motionEye](https://github.com/Motion-Project/motion))
- [Final steps](#Final_steps)

### Requirements

1. Raspberry Pi
2. USB WiFi (*Optional*)
3. Printer (*Phase III - Print server*)
3. Camera (*Phase IV - CCTV*)
2. SD Card (*4 GB or more*)
3. Computer (Windows, MacOS or Ubuntu) with:
	- Web browser
	- SSH client
	- SMB File explorer (*Explorer (Windows), Finder (MacOS) or Nautilus (Ubuntu)*)
	- [Telegram client](https://telegram.org/apps)
4. Internet access
5. Two static IP addresses available on the local network. *[IP_LAN]* and *[IP_WLAN]*
6. Default gateway IP (typically IP address of the router). *[IP_Gateway]*
7. Network mask bits (typically '/24'). *[Mask_bits]*
8. Telegram user name, *[Telegram Username]*
9. Name for Telegram bot. '*_bot*' will be added to the end of the name. *[Telegram Botname]*
10. If WiFi connection is available, *[WIFI_SSID]* and *[WIFI_Password]*

I use the following hardware, so other options might involve slight differences:
- [Raspberry Pi 2 Model B Rev 1.1](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)  
- [TP-Link USB WiFi Adapter TL-WN725N](https://www.tp-link.com/us/home-networking/usb-adapter/tl-wn725n/)
- [HP LaserJet P2035](https://support.hp.com/us-en/product/hp-laserjet-p2035-printer-series/3662025/manuals)
- [Raspberry Pi Camera Module v2.1](https://www.raspberrypi.org/products/camera-module-v2/)

---

## <a name="PHASE_I"></a>PHASE I: Basic installation of the Raspberry Pi

### Burn Raspberry Pi OS to SD card

*(From computer)*

Download and install [Raspberry Pi Imager](https://www.raspberrypi.org/software/)

Insert the SD into a card reader

Launch Raspberry Pi Imager

Choose SD card and choose OS '*Raspberry Pi OS (32-bit)*'

Click on '*WRITE*'

### First Startup and configuration of Raspberry Pi OS

*(From the Raspberry Pi)*

Connect a HMDI monitor, keyboard, mouse and LAN cable to the Raspberry Pi

Insert the SD card and turn Raspberry Pi on

Take note of the IP address displayed in the bottom right corner of the '*Welcome to Raspberry Pi*' window. This IP address will be referred to as *[DHCP_address]* from now on.

Set country config as follow:
- Country: Spain
- Language: European Spanish
- Timezone: Madrid
- Use English language: Yes
- Use US keyboard: No

Change password for the '*pi*' user account

Check '*This screen shows a black border around the desktop*' if required

Skip the '*Select WiFi Network*' window

Skip the '*Update Software*' window

Click on '*Restart*'

Once started, launch '*Raspberry Pi Configuration*' from the menu '*Preferences*'

In tab '*Interfaces*', check '*Enable*' for '*SSH*'

*(From computer)*

Access to Raspberry Pi via SSH: ```C:\> ssh pi@[DHCP_address]```
* '*[DHCP_address]*' is the IP address from of the '*Welcome to Raspberry Pi*' window
* If the message '*WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!*' is shown then delete file '*C:\Users\%USERNAME%\.ssh\known_hosts*'

### OS update and base software installation

*(From SSH console)*

```
    sudo apt install rpi-update
    sudo apt autoremove
    sudo apt upgrade
    sudo apt update
    sudo apt full-upgrade

    sudo apt install xrdp
    sudo apt install nmap
    sudo apt install telnet
    sudo apt install jq
```

### Set static IP Address to LAN interface

*(From SSH console)*

```
    sudo nano /etc/dhcpcd.conf

        # Add to the end of the file

        interface eth0
        static ip_address=[IP_LAN]/[Mask_bits]
        static routers=[IP_Gateway]
        static domain_name_servers=1.1.1.1

    sudo nano /etc/resolv.conf

        # Replace all the content

        nameserver 1.1.1.1
```

### Install driver for WiFi adapter, configur it and set static IP Address

*(From SSH console)*

```
    sudo wget http://downloads.fars-robotics.net/wifi-drivers/install-wifi -O /usr/bin/install-wifi
    sudo chmod +x /usr/bin/install-wifi
    sudo install-wifi
	
	sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

        # Replace all the content
        
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

### Reboot and check

*(From SSH console)*

```
    sudo reboot
```

*(From computer)*

Unplug Raspberry LAN cable and verify SSh access via WLAN: '*C:\> ssh pi@[IP_WLAN]*'

---

## <a name="PHASE_II"></a>PHASE II: Install the '*telegramMonitoring*' scripts

### Create a telegram bot

*(From Telegram client)*

Get your Telegram ID sending '*/start*' to '*@userinfobot*'. [Telegram ID]

Create bot sending to '*@BotFather*':
- */start*
- */newbot*
	- *[Telegram Botname]_bot*
	- *[Telegram Botname]_bot*
- */setdescription*
	- *@[Telegram Botname]_bot*
	- *Contact @[Telegram Username] for any information*
- */setcommands*
	- *@[Telegram Botname]_bot*
	- *help - Show available commands*

Get bot token sending '*/token*' to '*@BotFather*'. [Telegram Token]
		
### Install and configure SAMBA (SMB protocol)

*(From SSH console)*

```
    sudo mkdir /home/pi/telegramMonitoring

    sudo apt install samba samba-common -y
    # Select 'NO' to modify 'smb.conf'

    sudo nano /etc/samba/smb.conf

        # Add to the end of the file

        [telegramMonitoring]
        comment = telegramMonitoring folder
        path = /home/pi/telegramMonitoring
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

*(From computer)*

Verify access to '*\\\[IP_WLAN]\telegramMonitoring*' via Explorer (Windows), Finder (MacOS) or Nautilus (Ubuntu)

### Restore '*telegramMonitoring*' files

*(From computer)*

Copy all files and folders from '*telegramMonitoring*' to '*\\[IP_WLAN]\telegramMonitoring*'

### Enable and secure '*telegramMonitoring*' tasks

*(From SSH console)*

```
    sudo nano /home/pi/telegramMonitoring/telegramInfo.sh

        # Token for bot
        telegramToken="[Telegram Token]"

        # ID for Telegram user account
        telegramId="[Telegram ID]"

    EDITOR=nano crontab -e

        # Add to the end of the file

        # Tasks to be done at start up
        @reboot (sudo /home/pi/telegramMonitoring/startUp.sh)

        # Tasks to be done every minute
        * * * * * (sudo /home/pi/telegramMonitoring/heartBeat.sh)

        # Tasks to be done every 4 hours
        0 */4 * * * (sudo /home/pi/telegramMonitoring/keepAlive.sh)

    sudo nano /home/pi/.bashrc

        # Add to the end of the file

        # Tasks to be done on log in
        /home/pi/telegramMonitoring/logIn.sh > /dev/null 2>&1

    sudo chmod a+rwx --recursive --verbose /home/pi/telegramMonitoring
    sudo chown pi:pi --verbose --recursive /home/pi/telegramMonitoring

    sudo reboot
```

### Check '*telegramMonitoring*' 

*(From Telegram client)*

Type ```/help``` the for available commands and test each of them

---

## <a name="PHASE_III"></a>PHASE III: Install the print service

*(Thanks to Gus for their blog entry '[Raspberry Pi Print Server: Setup a Network Printer](https://pimylifeup.com/raspberry-pi-print-server/)' published on '[Pi My Life Up](https://pimylifeup.com/)')*

### Install CUPS

*(From SSH console)*

```
    sudo apt install cups
    sudo usermod -a -G lpadmin pi
    sudo cupsctl --remote-any
    sudo systemctl restart cups

	sudo apt install samba

	sudo nano /etc/samba/smb.conf

        # Change the values to match the following.

        # CUPS printing.  
        [printers]
        comment = All Printers
        browseable = no
        path = /var/spool/samba
        printable = yes
        guest ok = yes
        read only = yes
        create mask = 0700

        # Windows clients look for this share name as a source of downloadable
        # printer drivers
        [print$]
        comment = Printer Drivers
        path = /var/lib/samba/printers
        browseable = yes
        read only = no
        guest ok = no
```

### Configure printer

*(From web browser)*

Connect printer to the Raspberry via USB and turn it on

Browse '*\\\[IP_WLAN]:631*' and click '*Administration*' in the navigation menu at the top of the screen

Click on the '*Add Printer*' button, in the '*Printers*' section

Select the printer to set up. In my case, '*HP LaserJet P2035 (HP LaserJet P2035)*'

Click the '*Continue*'

Check '*Share This Printer*' and click '*Continue*'

Select the model of your printer and click the '*Add Printer*'

*(From computer)*

Configure the printer in your computer and print out a test page

### Add '*/printer*' command to '*telegramMonitoring*'

*(From computer)*

Copy file 'printer.sh' to '\\[IP_WLAN]\telegramMonitoring\botCommands'

*(From SSH console)*

```
    sudo chmod a+rwx --recursive --verbose /home/pi/telegramMonitoring/botCommands/printer.sh
    sudo chown pi:pi --verbose --recursive /home/pi/telegramMonitoring/botCommands/printer.sh
```





---
sudo lpstat -W completed -u $(getent passwd | awk -F: '{print $1}' | paste -sd ',')

sudo strings /var/spool/cups/c00001 | grep -A 1 job-name




cupsctl
lpadmin 
lpinfo 
lp 
lpr
lpstat 
lpoptions 
lprm 
lpq
lpmove 




## <a name="PHASE_IV"></a>PHASE IV: CCTV

### Enable and test de camera

*(From SSH console)*

Option A:

```
    sudo raspi-config

    - Select option '3 Interface Options'
 
    - Select '<Select>'

    - Select 'P1 Camera'

    - Select '<Select>'

    - 'Would you like the camera interface to be enabled?'
    - Select '<Yes>'

    - 'The camera interface is enabled'
    - Select '<Ok>'

    - Select '<Finish>'

    - 'Would you like to reboot now?'
    - Select '<Yes>'
```

Option B:

```
    sudo raspi-config nonint do_camera 1
```

raspistill --verbose --output test.jpg


	Pruebas	
		3280x2464: raspistill --output /home/pi/Pictures/test.jpg
		640x480  : raspistill --output /home/pi/Pictures/test-small.jpg --width 640 --height 480
		video    : raspivid --output /home/pi/Pictures/test-video.h264
		No pink  : raspistill --verbose --settings --shutter $2 --vflip --hflip --ev -24 --ISO 100 --awb off --awbgains 1.0,1.0 --drc high --stats --nopreview --quality 10 --timeout 100 --output /home/pi/Pictures/test-nopink.jpg
~

https://eltallerdelbit.com/motioneye-raspberry-pi/

---

## <a name="Final_steps"></a>Final steps

Please, give me your feedback on github: [FIN392](https://github.com/FIN392)

---
---

### Acceso VPN

	Configuracion del router
	Configuracion de No-IP
	Configuracion de OpenDNS
	Configuracion de DNS-O-Matic

	fin392.ddns.net

