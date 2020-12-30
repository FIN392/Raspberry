#!/bin/bash

#
# Keeps running listening for messages and executing the commands that come to it
#
# To restart it:
#
#     sudo kill $(ps aux | grep --regexp "botListener.sh" | awk '{print $2}') ; sudo ./botListener.sh &
#

set -o errexit
set -o nounset
set -o pipefail

# Trap SIGINT
function stop()
{
	echo && echo "Canceled by user!"
}
trap 'stop' SIGINT

# Path for telegramMonitoring
tMPath=/home/pi/telegramMonitoring

# Get Token for bot and ID for Telegram user account
source $tMPath/telegramInfo.sh

telegramURL="https://api.telegram.org/bot$telegramToken/getUpdates"

echo -e "<code>%F0%9F%91%8D\nListener is ON. Use </code>/help<code> to see the available commands</code>" | $tMPath/sendTelegramMessage.sh

# Take last message ID
CURLOUTPUT=$(curl -s -X POST $telegramURL -d offset=-1) 2>&1
LASTMESSAGE_ID=$(echo $CURLOUTPUT | jq '.result[0].message.message_id')

while true
do

	# Take info from last message
	CURLOUTPUT=$(curl -s -X POST $telegramURL -d offset=-1) 2>&1
	MESSAGE_ID=$(echo $CURLOUTPUT | jq '.result[0].message.message_id')
	TEXT=$(echo $CURLOUTPUT | jq '.result[0].message.text' | tr '[:upper:]' '[:lower:]')
	FROM=$(echo $CURLOUTPUT | jq '.result[0].message.from.id')

	# If it comes from the Telegram user account and the message ID has changed...
	if [ $FROM = $telegramId ] && [ $LASTMESSAGE_ID != $MESSAGE_ID ]
	then

		OUTPUT=$( \
			echo "%F0%9F%A4%94" ; \
			echo "I don't understand what you mean by $TEXT. Please use </code>/help<code> to see the available commands" ; \
		) 

		# /help
		if [ $TEXT = '"/help"' ]
		then
			OUTPUT="$( \
				echo "%E2%84%B9" ; \
				echo "Available commands:" ; \
				echo "Show this help                 : </code>/help<code>" ; \
			)"
			for filename in $(ls -1 --almost-all "$tMPath/botCommands");
			do
				if ( getfacl $tMPath/botCommands/$filename --omit-header --absolute-names | grep "user::" | grep "x" > /dev/null 2>&1 )
				then
					HELPTEXT=$(grep --ignore-case '^#HELP:' "$tMPath/botCommands/$filename" | cut --delimiter=':' --fields=2 | xargs)
					printf -v PAD %30s
					HELPTEXT=$HELPTEXT$PAD
					HELPTEXT=${HELPTEXT:0:30}
					OUTPUT=$OUTPUT$(echo -ne "\n$HELPTEXT : </code>/")
					OUTPUT=$OUTPUT$(echo -n $filename | cut --delimiter='.' --fields=1)
					OUTPUT=$OUTPUT$(echo "<code>")
				fi
			done

echo -ne "***\n<code>$OUTPUT</code>\n***\n"
echo -ne "***\n$tMPath/sendTelegramMessage.sh\n***\n"

		fi

echo -ne "***\n<code>$OUTPUT</code>\n***\n"
echo -ne "***\n$tMPath/sendTelegramMessage.sh\n***\n"

		
		# Exist 'botCommands/cmd_xxxx.sh'
		CMD="$tMPath/botCommands/$(echo $TEXT | tr --delete '/' | tr --delete '"').sh"
		if [[ -x "$CMD" ]]
		then
			OUTPUT=$($CMD)
		fi
		# Send output via Telegram
		echo "<code>$OUTPUT</code>" | $tMPath/sendTelegramMessage.sh

		# Take last message ID
		LASTMESSAGE_ID=$MESSAGE_ID
	fi

done
