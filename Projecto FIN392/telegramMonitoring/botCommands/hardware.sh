#!/bin/bash

#HELP: Show hardware
echo "%E2%9A%99"
cat /proc/cpuinfo   | grep "Model"       | awk -F ':' '{printf "Model        :%s\n",$2}'
cat /proc/cpuinfo   | grep "Serial"      | awk -F ':' '{printf "Serial number:%s\n",$2}'
cat /etc/os-release | grep "PRETTY_NAME" | awk -F '"' '{printf "OS           : %s\n",$2}'
cat /proc/meminfo   | grep "MemTotal"    | awk -F " " '{printf "Memory       : %s %s\n",$2,$3}'
echo
echo "Disk:"
df --total --human-readable --print-type | awk '{print " ",$0}'
echo
echo "USB devices:"
lsusb --verbose 2>/dev/null | grep --extended-regexp 'Bus|iProduct' | awk '{printf "  %s (%s)\n",a,$3 $4 $5 $6 $7 $8 $9}{a=$0}' | grep --regexp "^  Bus" | sort
