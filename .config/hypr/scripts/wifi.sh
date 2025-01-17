#!/bin/bash

icon_base="/usr/share/icons/ePapirus-Dark/32x32/"
icon_on="$icon_base/devices/network-wired.svg"
icon_off="$icon_base/panel/network-wired-disconnected.svg" 

function get_wifi_status {
        nmcli radio wifi
}

function send_notification {
        if [ "$1" == "on" ]; then
                dunstify -a "System" -i "$icon_on" -r 2593 -u low "Wifi On" -t 2500
        else
                dunstify -a "System" -i "$icon_off" -r 2593 -u low "Wifi Off" -t 2500
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

