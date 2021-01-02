#!/bin/bash

#
# EDITOR=nano crontab -e
#
#     (Add to beginning of file)
#
#     # telegramMonitoring: Check Internet connection every minute
#     * * * * * (sudo /home/pi/telegramMonitoring/internetConnection.sh)
#

# Path for telegramMonitoring
tMPath=/home/pi/telegramMonitoring

#
# Send message if Internet is down for more than 1 minute
#
datetime=$(date +"%Y-%m-%d %H:%M:%S")
ping -c 3 api.telegram.org > /dev/null 2>&1 && ping=1 || ping=0
if [ $ping -eq 1 ]; then
	if [ -f $tMPath/noInternet ]; then
		( \
			echo -e "<code>%F0%9F%94%8C" ; \
			echo "Internet connection has been down:" ; \
			awk /'/ {print $0,"OFF"}' $tMPath/noInternet ; \
			echo "$datetime ON</code>" ; \
		) | $tMPath/sendTelegramMessage.sh
		rm $tMPath/noInternet
	fi
else
	if [ ! -f $tMPath/noInternet ]; then
		echo $datetime > $tMPath/noInternet
	fi
fi
