#!/bin/bash

#HELP: Show printer status
echo "%F0%9F%96%A8"
echo -n "The printer is " ; lsusb | grep "03f0:5d17" --quiet && echo "ON" || echo "OFF"
