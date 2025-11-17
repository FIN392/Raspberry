![Logo](https://github.com/FIN392/Raspberry/raw/main/Raspberry-Logo.png)

# How to install *my* Raspberry Pi

## Requirements

- A Raspberry Pi
- An SD card
- Internet access
- A Windows, MacOS or Debian computer with a SD reader and an SSH client

## What do I have?

This is the components I have, so please keep in mind that this step-by-step guide may have slight differences in your case.
- [Raspberry Pi 2 Model B Rev 1.1](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)
- [TP-Link USB WiFi Adapter TL-WN725N](https://www.tp-link.com/us/home-networking/usb-adapter/tl-wn725n/)(*)
- [Windows 11](https://www.microsoft.com/en-us/software-download/windows11)

(*) The USB WiFi adapter is not necessary. You can connect the Raspberry Pi to your home router via a cable.

## Steps

1. [Write the Raspberry Pi OS to the SD card](#sd)
2. [First boot](#startup)
3. [Update and configure](#update)
4. [Backup](#backup)

## <a name="sd"></a>Write the Raspberry Pi OS to the SD card

*(Steps to take in Windows)*

Download [Raspberry Pi Imager](https://www.raspberrypi.org/software/).

Install and run it.

<img width="640" alt="image" src="https://github.com/user-attachments/assets/4fdeac5b-727d-4662-870b-28b4bb5720f2" />

Click '*CHOOSE DEVICE*' and select '*Raspberry Pi 2 - Model B*'.

Click '*CHOOSE OS*' and select '*Raspberry Pi OS (other)* / *Raspberry Pi OS Lite (32-bit)*'.

Clock '*CHOOSE STORAGE*' and select the SD card.

Click '*NEXT*'.

<img width="640" alt="image" src="https://github.com/user-attachments/assets/3bcacdaf-4763-4706-a0ed-7d0c02adc471" />

Click '*EDIT SETTING*'

Configure the following settings in the 'OS Customisation' window:

### General

Set hostname = fin392pi.local

Set username and password
- Username = fin392
- Password = abc123

Configure wireless LAN
- SSID = WLAN_1234
- Passowrd = ABCD1234ABCD
- Hidden SSID = OFF
- Wireless LAN country = ES

Set locale settings
- Time zone = Europe/Madrid
- Keyboard layout = es

### Services

Enable SSH = Use password authentication

### Options

Play sound when finished = OFF
Eject media when finished = ON
Enable telemetry = OFF

<img width="640" alt="image" src="https://github.com/user-attachments/assets/9ef359f2-39c7-402c-99f5-2e89fc6474bb" />

Click '*YES*'

<img width="640" alt="image" src="https://github.com/user-attachments/assets/a9bdc0aa-cb25-4875-af6c-18a95601d9d8" />

Click '*YES*'

<img width="640" alt="image" src="https://github.com/user-attachments/assets/306eb129-945d-4c65-80ee-5bdabfc0308f" />

Click '*CONTINUE*'

## <a name="startup"></a>First boot

*(Steps to take in Raspberry Pi)*

Connect a monitor to the Raspberry Pi's HDMI port, insert the SD card, and power it on.

After several minutes and restarts, you will see something similar to this:

```
Raspbian GNU/Linux 12 FIN392PI tty1
My IP address in 192.168.1.20 fe80:ef73:d389:f130:5526
FIN392PI login: _
```

Note the IP address.

You can now remove the HDMI cable from the Raspberry Pi. From this point forward, access will be through an SSH client.

*(Steps to take in Windows)*

From a command prompt window, run the SSH client with the following command:

```
C:\> ssh.exe fin392@192.168.1.20
```

If the following message is displayed...

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

...delete the following file:

```
C:\> del  C:\Users\fin392\.ssh\known_hosts
```

If the following message is displayed...

```
The authenticity of host '192.168.1.20 (192.168.1.20)' can't be established.
ED25159 key fingerprint is SHA256:MFKJ/n8PpDzevg3hmTvr+NFAjE32xn7K4LFW8zXPMTC.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

...type '*yes*'.

If everything has gone well, you will be asked for the password of the user '*fin392*':

```fin392@192.168.1.20's password:```

After type the password, if this message is displayed...

```
Linux FIN392PI 6.12.25+rpt-rpi-v7 #1 SMP Raspbian 1:6.12.25-1+rpt1 (2025-04-30) armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
fin392@FIN392PI:~ $
```

...congratulations, it's now inside your Raspberry Pi.

## <a name="update"></a>Update and configure

Now you will need to make some configurations, and for this it is easier to run everything as '*root*':

```
sudo -i
```

### 1. Force *sudo* to always ask for the password

Edit the sudoers file:

```
visudo
```

Replace line ```Defaults        env_reset``` with ```Defaults        env_reset, timestamp_timeout=0```.

### 2. Change dynamic IP (DHCP) by static IP

```
nmcli con mod "preconfigured" ipv4.addresses 192.168.1.20/24
nmcli con mod "preconfigured" ipv4.gateway 192.168.1.1
nmcli con mod "preconfigured" ipv4.dns "1.1.1.1 8.8.8.8"
nmcli con mod "preconfigured" ipv4.method manual
```

```
nmcli con down "preconfigured" && nmcli con up "preconfigured"
```

After this step, you will need to reconnect to your Raspberry Pi. This time using the new IP address.

```
C:\> ssh.exe fin392@192.168.1.20
```

### 3. Update the OS

First...

```
sudo -i
apt update -y
apt upgrade -y
apt autoremove -y
```
...and then...

```
sudo reboot
```

## <a name="backup"></a>Backup

It is highly recommended to make a copy of your SD card.

'*Win32 Disk Imager*' is an excellent option for this, so visit its official website [win32diskimager.org](https://win32diskimager.org/).

---
