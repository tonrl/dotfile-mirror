#!/bin/bash
icon_base="/usr/share/icons/ePapirus-Dark/32x32/"
icon_volume_high="$icon_base/panel/audio-on.svg" 
icon_volume="$icon_base/panel/audio-volume-high.svg" 
icon_volume_mid="$icon_base/panel/audio-volume-medium.svg" 
icon_volume_low="$icon_base/panel/audio-volume-low.svg" 
icon_mute="$icon_base/panel/audio-volume-muted.svg"
mic_mute="$icon_base/panel/mic-off.svg"
mic_on="$icon_base/panel/mic-on.svg"

function get_volume {
        amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
        amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function mic_on_off {
        pactl get-source-mute @DEFAULT_SOURCE@ | grep -Po '(?<=Mute: )(yes|no)' | grep no > /dev/null
}

function send_notification {
        volume=`get_volume`
        # Make the bar with the special character ─ (it's not dash -)
        if [ "$volume" -gt 0 ]; then
                bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')"─"
        else
                bar=""
        fi
        # Send the notification
        if [ "$volume" -ge 80 ]; then
                dunstify -a "System" -i "$icon_volume_high" -r 2593 -u low "Volume: ${volume}%" "$bar" -t 2500
        elif [ "$volume" -ge 50 ]; then
                dunstify -a "System" -i "$icon_volume" -r 2593 -u low "Volume: ${volume}%" "$bar" -t 2500

        elif [ "$volume" -ge 10 ]; then
                dunstify -a "System" -i "$icon_volume_mid" -r 2593 -u low "Volume: ${volume}%" "$bar" -t 2500
        elif [ "$volume" -eq 0 ]; then
                dunstify -a "System" -i "$icon_mute" -t 2500 -r 2593 -u low "Volume: ${volume}%" "$bar" 
        else
                dunstify -a "System" -i "$icon_volume_low" -r 2593 -u low "Volume: ${volume}%" "$bar" -t 2500

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
                        dunstify -a "System" -i "$icon_mute" -t 2500 -r 2593 -u low "Mute"
                else
                        send_notification
                fi
                ;;
        mic)
                pactl set-source-mute @DEFAULT_SOURCE@ toggle
                if mic_on_off ; then 
                        dunstify -a "System" -i "$mic_on" -t 2500 -r 2593 -u low "Active"
                else
                        dunstify -a "System" -i "$mic_mute" -t 2500 -r 2593 -u low "Mute"
                fi
                ;;

esac
