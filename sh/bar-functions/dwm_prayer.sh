#!/bin/sh

dwm_prayer() {

    url="https://timesprayer.com/en/bangladesh-bd/dhaka/"

    base="$(curl --silent $url | pup "div.nextprayer-time")"

    name="$(echo $base | pup "div.summary text{}" | cut -d ' ' -f2)"

    t_left="$(echo $base | pup "time#countdown text{}")"

    t_left_hr="$(echo $t_left | cut -d ':' -f1)"
    t_left_min="$(echo $t_left | cut -d ':' -f2)"

    printf "%s" "🕌 $name in $t_left_hr hr $t_left_min min"

}

dwm_prayer
