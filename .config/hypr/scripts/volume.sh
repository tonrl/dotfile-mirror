#!/usr/bin/env bash

readonly icon_base="$HOME/.local/share/icons/ePapirus/32x32/"

# volume output
icon_volume_max="$icon_base/panel/audio-on.svg" 
icon_volume_high="$icon_base/panel/audio-volume-high.svg" 
icon_volume_mid="$icon_base/panel/audio-volume-medium.svg" 
icon_volume_low="$icon_base/panel/audio-volume-low.svg" 
icon_mute="$icon_base/panel/audio-volume-muted.svg"

# Volume input icons
mic_mute="$icon_base/panel/mic-off.svg"
mic_on="$icon_base/panel/mic-on.svg"

# Additional option
swaync_op="-h string:x-canonical-private-synchronous:brightness_notif"
expireTime=1000

function usage {
        echo "Usage: $0 {up|down|mute|mic} [step]"
        exit 1
}

function check_dependencies {
        command -v pactl >/dev/null 2>&1 || { echo "pactl required but not installed."; exit 1; }
        command -v notify-send >/dev/null 2>&1 || { echo "notify-send required but not installed."; exit 1; }
}

function get_volume {
        # amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
        if ! pactl info | grep -q "Default Sink"; then
                echo "No default audio sink found." >&2
                exit 1
        fi
        pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%'
}

function is_mute {
        pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" > /dev/null
}

function mic_on_off {
        sleep 0.05
        pactl get-source-mute @DEFAULT_SOURCE@ | grep -Po '(?<=Mute: )(yes|no)' | grep no > /dev/null
}

function notification_fn {
        local volume="$1"
        local icon_op="$2"
        notify-send -a "System" -i "$icon_op" -r 2593 -u low ${swaync_op} "Lautstärke: ${volume}%" "$bar" -t $expireTime

}

function send_notification {
        local volume=$(get_volume)
        # Make the bar with the special character ─ (it's not dash -)
        if [ "$volume" -gt 0 ]; then
                if [ "$volume" -ge 100 ]; then
                        # bar=$(seq -s "─" $(("$volume" / 3)) | sed 's/[0-9]//g')"─"
                        volume=100
                        bar=$(printf '─%.0s' $(seq 1 "$((volume / 3))"))
                else
                        bar=$(printf '─%.0s' $(seq 1 "$((volume / 3))"))
                fi
        else
                bar=""
        fi
        # Send the notification
        if [ "$volume" -eq 0 ]; then
                notify-send -a "System" -i "$icon_mute" -t $expireTime -r 2593 -u low ${swaync_op} "Lautstärke: ${volume}%" "Your Speakers are Disabled"
        else
                if [ "$volume" -ge 85 ]; then
                        icon_op=${icon_volume_max}

                elif [ "$volume" -ge 50 ]; then
                        icon_op=${icon_volume_high}

                elif [ "$volume" -ge 30 ]; then
                        icon_op=${icon_volume_mid}

                else
                        icon_op=${icon_volume_low}
                fi
                notification_fn "$volume" "$icon_op"
        fi
}

function unmute {
        local volume=$(get_volume)
        if [ "$volume" -eq 0 ]; then
                pactl set-sink-volume @DEFAULT_SINK@ 5% > /dev/null
                send_notification
        else
                send_notification
        fi
}

function volume_down_mute {
        local volume=$(get_volume)
        if [ "$volume" -le 5 ]; then
                # amixer -D pulse set Master 1+ off > /dev/null
                # amixer -D pulse set Master 5%- > /dev/null
                pactl set-sink-mute @DEFAULT_SINK@ true > /dev/null
        else
                pactl set-sink-mute @DEFAULT_SINK@ false > /dev/null
        fi

        pactl set-sink-volume @DEFAULT_SINK@ -5% > /dev/null
        send_notification
}

function volume_up {
        local  volume=$(get_volume)
        # echo "$volume"
        # Set the volume on (if it was muted)
        # amixer -D pulse set Master on > /dev/null
        pactl set-sink-mute @DEFAULT_SINK@ false > /dev/null
        # Up the volume (+ 5%)
        if [ "$volume" -le 90 ]; then
                pactl set-sink-volume @DEFAULT_SINK@ +5% > /dev/null
        elif [ "$volume" -ge 95 ]; then
                pactl set-sink-volume @DEFAULT_SINK@ 100% > /dev/null
        fi
        send_notification
}

case $1 in
        up)
                volume_up
                ;;
        down)
                volume_down_mute
                ;;
        mute)
                volume=$(get_volume)
                # Toggle mute
                # amixer -D pulse set Master 1+ toggle > /dev/null
                pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null
                if is_mute ; then
                        notify-send -a "System" -i "$icon_mute" -t $expireTime -r 2593 -u low $swaync_op "Lautstärke: ${volume}%" "Your Speakers are Disabled"
                else
                        unmute
                fi
                ;;
        mic)
                pactl set-source-mute @DEFAULT_SOURCE@ toggle
                if mic_on_off ; then 
                        notify-send -a "System" -i "$mic_on" -t $expireTime -r 2593 -u low $swaync_op "Mikrofon: An" "Your microphone is now turned on"
                else
                        notify-send -a "System" -i "$mic_mute" -t $expireTime -r 2593 -u low $swaync_op "Mikrofon: Aus" "Your microphone is now turned off"
                fi
                ;;
        *) usage 
                ;;

esac
