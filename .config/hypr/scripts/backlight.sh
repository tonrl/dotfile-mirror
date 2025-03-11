#!/bin/bash
icon_base="/usr/share/icons/ePapirus-Dark/32x32"
high_icon="$icon_base/panel/brightness-high-symbolic.svg"
mid_icon="$icon_base/panel/brightness-symbolic.svg"
low_icon="$icon_base/panel/brightness-low-symbolic.svg" 

function get_brightness {
        brightness=$(brightnessctl get)
        max_brightness=$(brightnessctl max)
        echo $((brightness * 100 / max_brightness))
}

function send_notification {

        brightness=$(get_brightness)
        brightness=${brightness%%.*}

        if [ "$brightness" -gt 0 ]; then
                bar=$(seq -s "─" $(($brightness / 3)) | sed 's/[0-9]//g')"─"
        else
                bar=""
        fi

        if [ "$brightness" -ge 80 ]; then
                notify-send -a "System" -i "${high_icon}" -r 2593 -u low "Brightness: ${brightness}" "$bar" -t 4000

        elif [ "$brightness" -ge 30 ]; then
                notify-send -a "System" -i "${mid_icon}" -r 2593 -u low "Brightness: ${brightness}" "$bar" -t 4000
        
        elif [ "$brightness" -eq 0 ]; then
                notify-send -a "System" -i "${low_icon}" -r 2593 -u low "Brightness: ${brightness}" "Backlight off" -t 4000
        else
                notify-send -a "System" -i "${low_icon}" -r 2593 -u low "Brightness: ${brightness}" "$bar" -t 4000
        fi  

}

function brightness_up {
        brightness=$(get_brightness)
        brightness=${brightness%%.*}

        if [ "$brightness" -lt 1 ]; then
                brightnessctl -qe s +1%
        elif [ "$brightness" -lt 10 ]; then
                brightnessctl -q s +1%
        else
                brightnessctl -q s +5%
        fi
}
function brightness_down {
        brightness=$(get_brightness)
        brightness=${brightness%%.*}

        if [ "$brightness" -le 1 ]; then
                brightnessctl -qe s 1%-
        elif [ "$brightness" -le 10 ]; then
                brightnessctl -q s 1%-
        else
                brightnessctl -q s 5%-
        fi
}

case $1 in
        up)
                brightness_up
                send_notification
                ;;
        down)
                brightness_down
                send_notification
                ;;
esac


