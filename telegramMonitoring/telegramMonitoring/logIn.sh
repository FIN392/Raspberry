#!/bin/bash
my_path=$(dirname "$0")

#
# Send message with session information
#
( \
	echo -e "<code>%F0%9F%96%90\nNew session started:" ; \
	echo "USER=$USER" ; \
	echo "SSH_CONNECTION=$SSH_CONNECTION</code>" \
) | $my_path/sendTelegramMessage.sh
