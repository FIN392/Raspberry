#!/bin/bash

#HELP: Show active IPs
echo "%F0%9F%92%BB"
ip address | grep --regexp " mtu " --regexp "inet " | awk '{printf "%-8s %s\n",a,$2}{a=$2}' | grep --regexp ".*: *[0-9]"
