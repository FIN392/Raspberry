#!/bin/bash

#HELP: List of logged in users
echo "%F0%9F%91%A5"
w | tail -n +2 | awk '{for(i=1;i<=NF;i++) if(i!=5 && i!=6 && i!=7) printf "%s%s", $i, (i==NF?"\n":" ");}' | column -t
