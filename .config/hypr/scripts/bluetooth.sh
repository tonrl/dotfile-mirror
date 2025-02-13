#!/bin/bash

icon_base="/usr/share/icons/ePapirus-Dark/32x32/"
icon_on="$icon_base/panel/bluetooth-active.svg"
icon_off="$icon_base/panel/bluetooth-disabled.svg"

function get_bluetooth_status {
        bluetoothctl show | grep PowerState | awk '{print $2}'
}
function send_notification {
        if [ "$1" == "on" ]; then
                dunstify -a "radio" -i "$icon_on" -r 2593 -u low "Bluetooth Enabled" "Your Bluetooth is now turned on." -t 2500
        elif [ "$1" == "off" ]; then
                dunstify -a "radio" -i "$icon_off" -r 2593 -u low "Bluetooth Disabled" "Your Bluetooth is now turned off" -t 2500
        else
                dunstify -a "radio" -i "$icon_on" -r 2593 -u low "Error" -t 2500
                
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

