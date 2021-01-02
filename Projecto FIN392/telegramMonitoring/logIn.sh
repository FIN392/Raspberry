#!/bin/bash

#
# sudo nano /home/pi/.bashrc
#
#     (Add to the end of the file)
#
#     # telegramMonitoring: Log in message
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
