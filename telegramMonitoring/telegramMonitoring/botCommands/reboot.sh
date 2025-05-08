#!/bin/bash

#HELP: Reboot NOW
echo "%F0%9F%98%B1"
echo "I'm going to reboot in 1 minute! If everything goes well, I'll be back in 2 minutes"
sudo shutdown --reboot +1 > /dev/null 2>&1
