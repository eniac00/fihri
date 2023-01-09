#!/bin/sh

nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {printf "%s%s%% %s\n", " ", $2, $3}}'
