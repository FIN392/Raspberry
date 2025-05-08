#!/bin/bash
my_path=$(dirname "$0")

#
# Send message if Internet is down for more than 1 minute
#
datetime=$(date +"%Y-%m-%d %H:%M:%S")
ping -c 3 api.telegram.org > /dev/null 2>&1 && ping=1 || ping=0
if [ $ping -eq 1 ]; then
	if [ -f $my_path/noInternet ]; then
		( \
			echo -e "<code>%F0%9F%94%8C" ; \
			echo "Internet connection has been down:" ; \
			awk /'/ {print $0,"OFF"}' $my_path/noInternet ; \
			echo "$datetime ON</code>" ; \
		) | $my_path/sendTelegramMessage.sh
		rm $my_path/noInternet
	fi
else
	if [ ! -f $my_path/noInternet ]; then
		echo $datetime > $my_path/noInternet
	fi
fi
