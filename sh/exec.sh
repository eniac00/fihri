#!/bin/bash

filename="/home/abir/sh/input"

email_pass=$(sed -n 1p $filename)

email=$(echo $email_pass | cut -f1 -d\| | tr -d ' ')
password=$(echo $email_pass | cut -f2 -d\| | tr -d ' ')

cnfm=$(sudo systemctl status nordvpnd | grep "active (running)")


if [ "$cnfm" = "" ]; then
    echo "nordvpnd is not running; staring now..."
    sudo systemctl start nordvpnd
    echo "done!!!"
    /home/abir/sh/expect_script.expect "$email" "$password"
else
    /home/abir/sh/expect_script.expect "$email" "$password"
fi

echo "process running"

nordvpn connect Singapore

echo "connected to Singapore Server"

while :
do

    read -p "If you want to quit type \"done\" exactly: " sure

    if [ "done" = "$sure" ]; then
        nordvpn logout
        sudo systemctl stop nordvpnd
        echo "logged out and successfully stopped nordvpnd"
        break
    else
        echo -e "\e[1;31mwrongly typed try again...\e[m"
    fi

done
