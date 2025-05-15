#!/bin/bash
my_path=$(dirname "$0")

#
# Send a file via Telegram to the user account from bot
#
# Return JSON with result from Telegram's API
#

# Get Token for bot and ID for Telegram user account
source $my_path/telegramInfo.sh

telegramURL="https://api.telegram.org/bot$telegramToken/sendDocument"

# File to send
fileName="$@"

if [ -f "$fileName" ]; then
        echo "fichero a enviar: $fileName"
        curl \
            --silent \
            --request POST "$telegramURL" \
            --form "chat_id=$telegramId" \
            --form "document=@$fileName" \
        | jq -M ""
else
        echo "No exist"
fi
