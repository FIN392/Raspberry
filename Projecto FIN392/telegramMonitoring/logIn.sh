#!/bin/bash

#
# Tasks to be done on log in
#
# sudo nano /home/pi/.bashrc
#
#     # Tasks to be done on log in
#     /home/pi/telegramMonitoring/logIn.sh > /dev/null 2>&1
#

# Path for telegramMonitoring
tMPath=/home/pi/telegramMonitoring

#
# Send message with session information
#
( \
	echo -e "<code>%F0%9F%96%90\nNew session started:" ; \
	echo "USER=$USER" ; \
	echo "SSH_CONNECTION=$SSH_CONNECTION</code>" \
) | $tMPath/sendTelegramMessage.sh

#
# ...
#
