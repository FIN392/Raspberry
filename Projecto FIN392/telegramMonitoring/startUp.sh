#!/bin/bash

#
# Tasks to be done at start up
#
# EDITOR=nano crontab -e
#
#     # Tasks to be done at start up
#     @reboot (sudo /home/pi/telegramMonitoring/startUp.sh)
#

# Path for telegramMonitoring
tMPath=/home/pi/telegramMonitoring

#
# Wait 30 seconds
#
sleep 30

#
# Send message with star up information: IPs and last downtime periods
#
( \
	echo -e "<code>%E2%9C%A8\nRaspberry started!</code>" \
) | $tMPath/sendTelegramMessage.sh

#
# Keeps running listening for messages and executing the commands that come to it
#
$tMPath/botListener.sh &
