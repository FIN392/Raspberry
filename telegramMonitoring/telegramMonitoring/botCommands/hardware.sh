#!/bin/bash

#HELP: Show hardware
echo "%E2%9A%99"
cat /proc/cpuinfo       | grep "Model"       | awk -F ':' '{printf "Model :%s\n",$2}'
cat /proc/cpuinfo       | grep "Serial"      | awk -F ':' '{printf "Serial:%s\n",$2}'
cat /etc/os-release     | grep "PRETTY_NAME" | awk -F '"' '{printf "OS    : %s",$2}'
cat /etc/debian_version                      | awk -F 'º' '{printf ", version %s\n",$1}'
uname --kernel-release                       | awk -F 'º' '{printf "Kernel: %s",$1}'
uname --kernel-version                       | awk -F 'º' '{printf "/ %s\n",$1}'
echo
cat /proc/meminfo   | grep "MemTotal"    | awk -F " " '{printf "Memory: %s %s\n",$2,$3}'
echo
echo "Disk:"
df -h --total | awk 'NR==1 || /^Filesystem/ {print $1, $2, $5, $6} !/^Filesystem/ && NR>1 {print $1, $2, $5, $6}' | column -t
