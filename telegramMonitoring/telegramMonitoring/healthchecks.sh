#!/bin/bash
my_path=$(dirname "$0")

#
# Send KEEPALIVE message to healthchecks.io
#
curl -X GET "$(cat $my_path/healthchecks.config)"
