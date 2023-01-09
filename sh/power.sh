#!/bin/bash

options="Poweroff\nReboot"
selected=$(echo -e $options | dmenu -i -p "Poweroff or Reboot")
choice_options="Yes\nNo"

if [[ $selected = "Poweroff" ]]; then
    choice=$(echo -e $choice_options | dmenu -i -p "Are you sure?")
    if [[ $choice = "Yes" ]]; then
        poweroff
    fi
elif [[ $selected = "Reboot" ]]; then
    choice=$(echo -e $choice_options | dmenu -i -p "Are you sure?")
    if [[ $choice = "Yes" ]]; then
        reboot
    fi
fi
