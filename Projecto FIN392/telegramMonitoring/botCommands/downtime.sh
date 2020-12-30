#!/bin/bash

#HELP: List of last downtime periods
echo "%F0%9F%9A%AB"
cat /var/log/messages | awk /'Booting Linux/ {printf "%s %s %s OFF\n%s %s %s ON\n\n",a,b,c,$1,$2,$3}{a=$1}{b=$2}{c=$3}'
