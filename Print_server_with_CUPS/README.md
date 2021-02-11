![Logo](https://github.com/FIN392/Raspberry/raw/main/images/CUPS-Logo.png)

# Print server with CUPS

The goal is to use Raspberry as print server and get notifications via Telegram.

Please, send me your comments, critics, doubts, requests or sues.

## Requirements

- [Raspberry Pi](https://www.raspberrypi.org). It should be up and running with access to Internet (only HTTPS port is required, so it is pretty secure).
- A printer connected to the Raspberry via USB.
- [telegramMonitoring](https://github.com/FIN392/Raspberry/edit/main/telegramMonitoring)  installed.

## Steps

1. ...[Installation of '*CUPS*'](#CUPS)
2. ...[bbb](#bbb)
3. ...[ccc](#ccc)

## <a name="CUPS"></a>Installation of '*CUPS*'

*(Special thanks to Gus for their blog entry '[Raspberry Pi Print Server: Setup a Network Printer](https://pimylifeup.com/raspberry-pi-print-server/)' published on '[Pi My Life Up](https://pimylifeup.com/)')*





## <a name="bbb"></a>bbb

bbb ...

## <a name="ccc"></a>ccc

ccc ...

---


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

---
### CHECK
### Add '*/printer*' command and './spoolCheck.sh' script to '*telegramMonitoring*'

*(From computer)*

Copy file 'printer.sh' to '\\[IP_WLAN]\telegramMonitoring\botCommands'

*(From SSH console)*

```
    sudo chmod a+rwx --recursive --verbose /home/pi/telegramMonitoring/botCommands/printer.sh
    sudo chown pi:pi --verbose --recursive /home/pi/telegramMonitoring/botCommands/printer.sh
```
### CHECK
