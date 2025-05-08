#!/bin/bash

icon_base="/usr/share/icons/Papirus-Dark/32x32/"
icon_on="$icon_base/status/network-wired-activated-locked.svg"
icon_off="$icon_base/status/network-flightmode-on.svg" 
expireTime=1500

function get_wifi_status {
        nmcli radio wifi
}

function send_notification {
        if [ "$1" == "on" ]; then
                notify-send -a "radio" -i "$icon_on" -r 2593 -u low "Wi-Fi Enabled" "Your Wi-Fi is now turned on" -t $expireTime
        else
                notify-send -a "radio" -i "$icon_off" -r 2593 -u low "Wi-Fi Disabled" "Your Wi-Fi is now turned off" -t $expireTime
        fi
}

wifi_status=$(get_wifi_status)
if [ "$wifi_status" == "enabled" ]; then
        nmcli radio wifi off > /dev/null
        send_notification "off"
else
        nmcli radio wifi on > /dev/null
        send_notification "on"
fi

