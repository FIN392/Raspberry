![Logo](https://github.com/FIN392/Raspberry/raw/main/images/telegramMonitoring-Logo.png)

# telegramMonitoring:<br>How to mange your Raspberry Pi through Telegram?

The goal is to do a basic monitoring of a Raspberry via Telegram.

What can you do?

1. You will get a Telegram message...
- ...each time the Raspberry is started.
- ...each time an user log in.
- ...each time the Internet connection is recovered after an outage.
- ...every 4 hours just to inform that it's still alive.

2. You will be able to ask for the following information:
- Last time the Raspberry was down.
- Hardware (CPU, memory, disk, USB devices, etc.).
- IP addresses.
- CPU and GPU temperature.
- How long has it been on.
- List of logged in users.

3. You will be able of reboot the Raspberry.

In addition, you could add more commands (eg: send a photo, print a file, check network devices, etc.).

Please, send me your comments, critics, doubts, requests or sues, as well as any additional command you create.

## Requirements

- [Raspberry Pi](https://www.raspberrypi.org). It should be up and running with access to Internet (only HTTPS port is required, so it is pretty secure).
- [Telegram](https://telegram.org). You should have an active Telegram account.

## Steps

1. [Create a Telegram bot](#bot).
2. [Installation of '*telegramMonitoring*'](#installation).
3. [Testing the commands](#testing).
4. [How to add your own bot commands](#more).

## <a name="bot"></a>Create a Telegram bot

Do the following steps from Telegram:
1. Take note of your Telegram ID sending '*/start*' to '*@userinfobot*'. (This data will be referred to later as [Telegram ID])
2. Create bot sending the following '*/*' commands to '*@BotFather*':
- */start*
- */newbot*
	- *{Telegram Botname}_bot*
	- *{Telegram Botname}_bot*
- */setdescription*
	- *@{Telegram Botname}_bot*
	- *Contact @{your Telegram Username} for any information*
- */setcommands*
	- *@{Telegram Botname}_bot*
	- *help - Show available commands*
3. Take note of the bot token sending '*/token*' to '*@BotFather*'. (This data will be referred to later as [Telegram Token])

## <a name="installation"></a>Installation of '*telegramMonitoring*'

*(From a SSH remote connection)*

```
# Everything is easier as ROOT ('I AM gROOT')
sudo -i

# ATTENTION!! Before copy&paste this section, replace [variable] by their value
telegramToken="[Telegram Token]"
telegramId="[Telegram ID]"

# Install the dependencies
# jq (command-line JSON processor)
apt install jq -y

# Install telegramMonitoring
rm -r /home/pi/telegramMonitoring
mkdir /home/pi/telegramMonitoring
cd /home/pi/Downloads
rm telegramMonitoring.tar.gz
wget -v https://github.com/FIN392/Raspberry/raw/main/telegramMonitoring/telegramMonitoring.tar.gz
tar -xzvf /home/pi/Downloads/telegramMonitoring.tar.gz -C /home/pi/
chmod a+rwx /home/pi/telegramMonitoring/*

# Set Telegram Token and Telegram ID
rm /home/pi/telegramMonitoring/telegramInfo.sh
echo "" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "########################################" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "#" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "# Set Telegram Token and Telegram ID" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "#" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "# $(date)" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "#" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "# Token for bot" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "telegramToken=$telegramToken" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "# ID for Telegram user account" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "telegramId=$telegramId" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "#" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "########################################" >> /home/pi/telegramMonitoring/telegramInfo.sh
echo "" >> /home/pi/telegramMonitoring/telegramInfo.sh

# Add 'logIn' to the '.bashrc' for 'pi'
echo "" >> /home/pi/.bashrc
echo "########################################" >> /home/pi/.bashrc
echo "#" >> /home/pi/.bashrc
echo "# telegramMonitoring: Log in message" >> /home/pi/.bashrc
echo "#" >> /home/pi/.bashrc
echo "# $(date)" >> /home/pi/.bashrc
echo "#" >> /home/pi/.bashrc
echo "/home/pi/telegramMonitoring/logIn.sh > /dev/null 2>&1" >> /home/pi/.bashrc
echo "#" >> /home/pi/.bashrc
echo "########################################" >> /home/pi/.bashrc
echo "" >> /home/pi/.bashrc

# Add taks to 'cron'.
crontabTasks=$( \
    echo "" ; \
    echo "########################################" ; \
    echo "#" ; \
    echo "# telegramMonitoring: Tasks" ; \
    echo "#" ; \
    echo "# $(date)" ; \
    echo "#" ; \
    echo "# Send initial message and start the bot listener" ; \
    echo "@reboot (sudo /home/pi/telegramMonitoring/startUp.sh)" ; \
    echo "# Check Internet connection every minute" ; \
    echo "* * * * * (sudo /home/pi/telegramMonitoring/internetConnection.sh)" ; \
    echo "# Send KEEPALIVE message at noon" ; \
    echo "0 12 * * * (sudo /home/pi/telegramMonitoring/stillAlive.sh)" ; \
    echo "#" ; \
    echo "########################################" ; \
    echo "" ; \
) 
(crontab -u pi -l 2>/dev/null; echo "$crontabTasks") | crontab -u pi -

# Exit from sudo
exit
```

## <a name="testing"></a>Testing the commands

Reboot the Raspberry: ```sudo reboot```. You will get the following messages via telegram:

```
✨
Raspberry started!

👍
Listener is ON. Use /help to see the available commands
```

Send '*/help*' to the bot, you will get the list of available commands:

```
ℹ️
Available commands:
Show this help                 : /help
List of last downtime periods  : /downtime
Show hardware                  : /hardware
Show active IPs                : /ip
Reboot NOW                     : /reboot
Show CPU and GPU temperature   : /temperature
Shows the time up              : /uptime
List of logged in users        : /users
```

Send the different commands and check the results.

## <a name="more"></a>How to add your own bot commands

To add more commands just add a new script in the directory '*~/telegramMonitoring/botCommands*'.

The script should follow this tempate:

```
#!/bin/bash

#HELP: {Brief description of 30 characters or less for the '/help' command}

echo "%E2%9A%99" # 'UTF-8 Hex Bytes' code of any icon (https://www.iemoji.com/)

#
# Add here your commands
# The output of the script will be send by Telegram
# The message is sent using a monospaced font, so you can format the output as you like
#
```

Be sure to secure the script with:

```sudo chmod a+wrx ~/telegramMonitoring/botCommands/{script name}.sh```

'*That's all folks!*' Please, send me your comments, critics, doubts, requests or sues.

---
