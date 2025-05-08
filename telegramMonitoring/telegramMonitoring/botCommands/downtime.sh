#!/bin/bash

#HELP: List of last downtime periods
echo "%F0%9F%9A%AB"
(echo "INDEX  TIME"; journalctl --list-boots | tail -n +2 | awk '{print $1, $4, $5, $6}') | column -t
