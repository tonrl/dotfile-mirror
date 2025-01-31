#!/bin/bash

icon_base="/usr/share/icons/ePapirus-Dark/32x32/"
icon_on="$icon_base/categories/tomato.svg" 
icon_off="$icon_base/categories/Temps.svg" 

function send_notification_on {
        dunstify -a "System" -i "$icon_on" -r 2593 -u low "Night Mode On" -t 3500
}
function send_notification_off {
        dunstify -a "System" -i "$icon_off" -r 2593 -u low "Night Mode Off" -t 3500
}

case $1 in
        on)
                # Set the volume on (if it was muted)
                send_notification_on
                hyprsunset -t 2500 > /dev/null
                ;;
        off)
                killall hyprsunset 
                send_notification_off
                ;;

esac
