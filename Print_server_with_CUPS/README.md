![Logo](https://github.com/FIN392/Raspberry/raw/main/images/CUPS-Logo.png)

# Print server with CUPS

The goal is to use Raspberry as print server and get notifications via Telegram.

Please, send me your comments, critics, doubts, requests or sues.

## Requirements

- [Raspberry Pi](https://www.raspberrypi.org). It should be up and running with access to Internet (only HTTPS port is required, so it is pretty secure).
- A printer connected to the Raspberry via USB.
- [telegramMonitoring](https://github.com/FIN392/Raspberry/edit/main/telegramMonitoring) installed.

## Steps

1. [Installation of '*CUPS*'](#CUPS).
2. [Configure printer](#config).
3. [Add Telegram monitoring](#telegram).

## <a name="CUPS"></a>Installation of '*CUPS*'

*(Special thanks to Gus for their blog entry '[Raspberry Pi Print Server: Setup a Network Printer](https://pimylifeup.com/raspberry-pi-print-server/)' published on '[Pi My Life Up](https://pimylifeup.com/)')*

*(From a SSH remote connection)*

```
# Everything is easier as ROOT ('I AM gROOT')
sudo -i

apt install cups -y
usermod -a -G lpadmin pi
cupsctl --remote-any
systemctl restart cups

apt install samba -y

nano /etc/samba/smb.conf

        # Change [printers] and [print$] section as follow.

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

# Exit from sudo
exit
```

## <a name="config"></a>Configure printer

*(From web browser)*

Connect printer to the Raspberry via USB and turn it on.

Browse '*\\\[IP_WLAN]:631*' and click '*Administration*' in the navigation menu at the top of the screen.

Click on the '*Add Printer*' button, in the '*Printers*' section.

Select the printer to set up. In my case, '*HP LaserJet P2035 (HP LaserJet P2035)*'.

Click the '*Continue*'.

Check '*Share This Printer*' and click '*Continue*'.

Select the model of your printer and click the '*Add Printer*'.

*(From computer)*

Configure the printer in your computer and print out a test page.

## <a name="telegram"></a>Add Telegram monitoring

Install [telegramMonitoring](https://github.com/FIN392/Raspberry/edit/main/telegramMonitoring).











'*That's all folks!*' Please, send me your comments, critics, doubts, requests or sues.

---
