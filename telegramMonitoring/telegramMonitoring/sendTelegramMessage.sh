#!/bin/bash
my_path=$(dirname "$0")

#
# Send a Telegram message to the user account from bot
#
# Return JSON with result from Telegram's API
#

# Get Token for bot and ID for Telegram user account
source $my_path/telegramInfo.sh

telegramURL="https://api.telegram.org/bot$telegramToken/sendMessage"

# Text message to send
textMessage=$@
if test ! -t 0; then
	while read
	do
		textMessage="${textMessage}%0A$REPLY"
	done < /dev/stdin
fi

curl --silent --request POST $telegramURL --data chat_id=$telegramId --data text="$textMessage" --data parse_mode=html | jq -M ""
