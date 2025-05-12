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

- [Requirements](#requirements)
- [Steps](#steps)
- [Get your Telegram ID](#get-your-telegram-id)
- [Create a Telegram bot](#create-a-telegram-bot)
- [Install '*telegramMonitoring*'](#install-telegrammonitoring)
- [Testing the commands](#testing-the-commands)
- [How to add your own bot commands](#how-to-add-your-own-bot-commands)

## <a name="id"></a>Get your Telegram ID

*(On Telegram)*

First of all, you need to know your Telegram ID (not username @xxxxx):
1. Open a chat with '*@userinfobot*'
2. Send text '*/start*'
3. Take note of your ID. This data will be referred to later as [Telegram ID]

## <a name="bot"></a>Create a Telegram bot

*(On Telegram)*

Now let's create a bot to communicate with our Raspberry:
1. Open a chat with '*@BotFather*'
2. Send text '*/newbot*'
3. '*Alright, a new bot. How are we going to call it? Please choose a name for your bot.*', type the name of your bot. I recommend that it be the same as the name of your Raspberry Pi (use the '*hostname*' command to find out)
4. '*Good. Now let's choose a username for your bot. It must end in `bot`. Like this, for example: TetrisBot or tetris_bot.*', type the same name ending in '*_bot*'
5. Take note of the token to access the HTTP API. It looks like this '*1234567890:12345678-90ABCDEFGHIJKLmnopqrstuvwx*'. This data will be referred to later as [Telegram Token])

## <a name="installation"></a>Install '*telegramMonitoring*'

*(On the Raspbery Pi console)*

```
# Everything is easier as ROOT ('I AM gROOT')

sudo -i
```

```
# First things first, keep your OS up to date

apt update -y
apt full-upgrade -y
apt autoremove -y
reboot
```

```
# Install the dependencies: 'jq' (command-line JSON processor)

apt install jq -y

jq --version
```

```
# Install telegramMonitoring

rm /opt/telegramMonitoring --recursive --force
mkdir /opt/telegramMonitoring
wget --verbose --output-document=/tmp/telegramMonitoring.tar.gz https://github.com/FIN392/Raspberry/raw/main/telegramMonitoring/telegramMonitoring.tar.gz
tar -xzvf /tmp/telegramMonitoring.tar.gz -C /opt/
chmod u=rwx,g=rx,o=rx /opt/telegramMonitoring --recursive

ls /opt/telegramMonitoring --format=long --recursive
```

```
# ATTENTION!! Before copy&paste this section, replace [variable] by their value

# Set variables telegramId and telegramToken

telegramId="[Telegram ID]"
telegramToken="[Telegram Token]"
```

```
# Set Telegram Token and Telegram ID

rm /opt/telegramMonitoring/telegramInfo.sh --force
lines="########################################
#
# Set Telegram Token and Telegram ID
#
# $(date)
#
telegramToken=\"$telegramToken\"
telegramId=\"$telegramId\"
#
########################################"
echo "$lines" >> /opt/telegramMonitoring/telegramInfo.sh
chmod u=rwx,g=rx,o=rx /opt/telegramMonitoring/telegramInfo.sh

cat /opt/telegramMonitoring/telegramInfo.sh
```

```
# Add 'logIn' to '/etc/profile'

lines="
########################################
#
# telegramMonitoring: Log in message
#
# $(date)
#
/opt/telegramMonitoring/logIn.sh > /dev/null 2>&1
#
########################################"
echo "$lines" >> /etc/profile

cat /etc/profile
```

```
# Add taks to 'cron'

rm /etc/cron.d/telegramMonitoring --force
lines="########################################
#
# telegramMonitoring: Tasks
#
# $(date)
#
# Send initial message and start the bot listener
@reboot root /opt/telegramMonitoring/startUp.sh
#
# Check Internet connection every 10 minutes
*/10 * * * * root /opt/telegramMonitoring/internetConnection.sh
#
# Send KEEPALIVE message to healthchecks.io every 10 minutes
*/10 * * * * root /opt/telegramMonitoring/healthchecks.sh
#
# Send KEEPALIVE message at noon
0 12 * * * root /opt/telegramMonitoring/stillAlive.sh
#
########################################

cat /etc/cron.d/telegramMonitoring
```

```
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
