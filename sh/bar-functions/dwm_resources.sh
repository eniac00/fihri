#!/bin/sh


dwm_resources () {

	free_output=$(free -h | grep Mem)
	MEMUSED=$(echo $free_output | awk '{print $3}')
	MEMTOT=$(echo $free_output | awk '{print $2}')
	CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%

	printf " %s/%s  %s" "$MEMUSED" "$MEMTOT" "$CPU"
}

dwm_resources
