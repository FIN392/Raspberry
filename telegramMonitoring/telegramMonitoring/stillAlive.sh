#!/bin/bash
my_path=$(dirname "$0")

#
# Send KEEPALIVE message
#
echo -e "<code>%F0%9F%91%8D\nStill alive. Use </code>/help<code> to see the available commands</code>" | $my_path/sendTelegramMessage.sh
