#!/bin/sh

dwm_pulse () {
    VOL=$(pamixer --get-volume)
    HEADPHONE=$(cat /proc/asound/card0/codec#0 | grep Pin-ctl | sed -n '7 p' | awk '{ print $3  }')

    if [ "$HEADPHONE" != "OUT" ]; then
        if [ "$VOL" = "muted" ] || [ "$VOL" -eq 0 ]; then
            printf " "
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf " %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf " %s%%" "$VOL"
        else
            printf " %s%%" "$VOL"
        fi
    else
        if [ $(pamixer --get-mute) = "true" ] || [ "$VOL" -eq 0 ]; then
            printf " "
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf " %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf " %s%%" "$VOL"
        else
            printf " %s%%" "$VOL"
        fi
    fi

}

dwm_pulse
