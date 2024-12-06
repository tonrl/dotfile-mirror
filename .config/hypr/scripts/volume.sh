#!/bin/bash
icon_base="/usr/share/icons/ePapirus-Dark/32x32/"
icon_volume="$icon_base/panel/audio-on.svg" 
icon_mute="$icon_base/panel/audio-volume-muted.svg"

function get_volume {
        amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
        amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
        volume=`get_volume`
        # Make the bar with the special character ─ (it's not dash -)
        # https://en.wikipedia.org/wiki/Box-drawing_character
        # bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g') [ -z "$bar" ] && bar="─"

        if [ "$volume" -gt 0 ]; then
                bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')"─"
        else
                bar=""
        fi
        # Send the notification
        if [ "$volume" -gt 0 ]; then
                dunstify -a "System" -i "$icon_volume" -r 2593 -u low "Volume: ${volume}%" "$bar" -t 1500
        else
                dunstify -a "System" -i "$icon_mute" -t 1500 -r 2593 -u low "Volume: ${volume}%" "$bar" 
        fi
}

case $1 in
        up)
                # Set the volume on (if it was muted)
                amixer -D pulse set Master on > /dev/null
                # Up the volume (+ 5%)
                amixer -D pulse set Master 5%+ > /dev/null
                send_notification
                ;;
        down)
                amixer -D pulse set Master on > /dev/null
                amixer -D pulse set Master 5%- > /dev/null
                send_notification
                ;;
        mute)
                # Toggle mute
                amixer -D pulse set Master 1+ toggle > /dev/null
                if is_mute ; then
                        dunstify -a "System" -i "$icon_mute" -t 1500 -r 2593 -u low "Mute"
                else
                        send_notification
                fi
                ;;
esac
