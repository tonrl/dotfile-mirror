#!/bin/bash

icon_base="/usr/share/icons/Papirus-Dark/32x32/"
icon_on="$icon_base/status/network-bluetooth-activated.svg"
icon_off="$icon_base/status/network-bluetooth.svg"
expireTime=1500

function get_bluetooth_status {
        bluetoothctl show | grep PowerState | awk '{print $2}'
}
function send_notification {
        if [ "$1" == "on" ]; then
                notify-send -a "radio" -i "$icon_on" -r 2593 -u low "Bluetooth Enabled" "Your Bluetooth is now turned on." -t $expireTime
        elif [ "$1" == "off" ]; then
                notify-send -a "radio" -i "$icon_off" -r 2593 -u low "Bluetooth Disabled" "Your Bluetooth is now turned off" -t $expireTime
        else
                notify-send -a "radio" -i "$icon_on" -r 2593 -u low "Error" -t $expireTime
                
        fi
}

bluetooth_state=$(get_bluetooth_status)

if [ "$bluetooth_state" == "on" ]; then
        bluetoothctl power off > /dev/null
        send_notification "off"
else
        bluetoothctl power on > /dev/null
        send_notification "on"
fi

