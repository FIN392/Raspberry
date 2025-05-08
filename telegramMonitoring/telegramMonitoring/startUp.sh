#!/bin/bash
my_path=$(dirname "$0")

#
# Wait 30 seconds
#
sleep 30

#
# Send message with star up information: IPs and last downtime periods
#
( \
	echo -e "<code>%E2%9C%A8\nRaspberry started!</code>" \
) | $my_path/sendTelegramMessage.sh

#
# Keeps running listening for messages and executing the commands that come to it
#
$my_path/botListener.sh &
