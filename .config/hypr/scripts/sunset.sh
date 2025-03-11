#!/bin/bash

icon_base="/usr/share/icons/ePapirus-Dark/32x32/"
icon_on="$icon_base/categories/tomato.svg" 
icon_off="$icon_base/categories/Temps.svg" 
DEEP_NIGHT_TEMP=1500
EVENING_TEMP=2000
DAY_TEMP=4000


function send_notification_on {
        notify-send -a "System" -i "$icon_on" -r 2593 -u low "Night Mode On" "$sunset_value"k -t 3500
}

function send_notification_no_off {
        notify-send -a "System" -i "$icon_on" -r 2593 -u low "Night Mode on" "DO NOT TURN OFF" -t 3500
}


function send_notification_off {
        notify-send -a "System" -i "$icon_off" -r 2593 -u low "Night Mode Off" -t 3500
}
# Get the current hour
current_hour=$(date +%H)

echo $current_hour
# Determine the value for hyprsunset based on the current time
if [ "$current_hour" -ge 22 ] && [ "$current_hour" -lt 24 ]; then
        sunset_value="$DEEP_NIGHT_TEMP"

elif [ "$current_hour" -ge 0 ] && [ "$current_hour" -lt 6 ]; then
        sunset_value="$DEEP_NIGHT_TEMP"

elif [ "$current_hour" -ge 18 ] && [ "$current_hour" -lt 22 ]; then
        sunset_value="$EVENING_TEMP"

else
        sunset_value="$DAY_TEMP"
fi


case $1 in
        on)
                # Set the volume on (if it was muted)
                send_notification_on
                # hyprsunset -t 1100 > /dev/null
                hyprsunset -t "$sunset_value" > /dev/null
                ;;
        off)
                if [ "$current_hour" -ge 0 ] && [ "$current_hour" -lt 6 ]; then
                        sunset_value="$EVENING_TEMP"
                        send_notification_no_off
                        hyprsunset -t "$sunset_value" > /dev/null
                else
                        killall hyprsunset
                        send_notification_off
                fi
                ;;
        *)
                echo "Usage: $0 {on|off}"
                echo ""
                echo "Turn on | off night mode"
                exit 1
                ;;

        esac
