#!/bin/sh


dwm_battery () {
    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

   if [[ "$STATUS" = "Charging" || "$STATUS" = "Unknown" ]]; then
       if [ $CHARGE -le 6 ]; then
           printf " %s%% %s" "$CHARGE" ""
        elif [ $CHARGE -le 25 ]; then
            printf " %s%% %s" "$CHARGE" ""
        elif [ $CHARGE -le 50 ]; then
            printf " %s%% %s" "$CHARGE" ""
        elif [ $CHARGE -le 75 ]; then
            printf " %s%% %s" "$CHARGE" ""
        else
            printf " %s%% %s" "$CHARGE" ""
        fi
    else
       if [ $CHARGE -le 6 ]; then
           printf " %s%%" "$CHARGE"
        elif [ $CHARGE -le 25 ]; then
            printf " %s%%" "$CHARGE"
        elif [ $CHARGE -le 50 ]; then
            printf " %s%%" "$CHARGE"
        elif [ $CHARGE -le 75 ]; then
            printf " %s%%" "$CHARGE"
        else
            printf " %s%%" "$CHARGE"
        fi
   fi
}

dwm_battery

