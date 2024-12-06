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
                bar=$(seq -s "─" $(($brightness / 5)) | sed 's/[0-9]//g')"─"
        else
                bar=""
        fi

        if [ "$brightness" -ge 80 ]; then
                dunstify -a "System" -i "${high_icon}" -r 2593 -u low "Brightness: ${brightness}" "$bar" -t 1500
        
        elif [ "$brightness" -ge 30 ]; then
                dunstify -a "System" -i "${mid_icon}" -r 2593 -u low "Brightness: ${brightness}" "$bar" -t 1500
        
        else
                dunstify -a "System" -i "${low_icon}" -r 2593 -u low "Brightness: ${brightness}" "$bar" -t 1500
        fi  

}

case $1 in
        up)
                brightnessctl -q s +5%
                send_notification
                ;;
        down)
                brightnessctl -q s 5%-
                send_notification
                ;;
esac
