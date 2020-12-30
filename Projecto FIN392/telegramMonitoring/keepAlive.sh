#!/bin/bash

#
# Tasks to be done every 4 hours
#
# EDITOR=nano crontab -e
#
#     # Tasks to be done every 4 hours
#     0 */4 * * * (sudo /home/pi/telegramMonitoring/keepAlive.sh)
#

# Path for telegramMonitoring
tMPath=/home/pi/telegramMonitoring

#
# Send KEEPALIVE message
#
echo -e "<code>%F0%9F%91%8D\nStill alive. Use </code>/help<code> to see the available commands</code>" | $tMPath/sendTelegramMessage.sh

#
# ...
#
