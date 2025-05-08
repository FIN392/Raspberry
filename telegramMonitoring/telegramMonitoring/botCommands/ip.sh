#!/bin/bash

#HELP: Show active IPs
echo "%F0%9F%92%BB"

echo "Local IP: $(hostname -I | awk '{print $1}')"

my_ip_json=$(curl --silent https://api.myip.com)
my_ip=$(echo "$my_ip_json" | jq -r '.ip')
my_country=$(echo "$my_ip_json" | jq -r '.country')
my_cc=$(echo "$my_ip_json" | jq -r '.cc')

echo "Public IP: $my_ip ($my_country, $my_cc)"

