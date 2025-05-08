#!/bin/bash

#HELP: Show CPU and GPU temperature
echo "%F0%9F%8C%A1"
echo "CPU: $(($(</sys/class/thermal/thermal_zone0/temp)/1000))'C"
echo "GPU: $(/usr/bin/vcgencmd measure_temp | awk -F "=" '{print $2}')"
