#!/bin/bash

icon_base="/usr/share/icons/Papirus-Dark/32x32/"
icon_pic="$icon_base/apps/lximage.svg" 
icon_err="$icon_base/categories/system-error.svg" 
expireTime=1500

send_notification() {
        local type="$1"
        local message=""
        local icon="$icon_pic"
        local filename="$2"

        case "$type" in

                pic)
                        message="Saved as: ${filename#$HOME/}"
                        ;;
                error)
                        message="$2"
                        icon="$icon_err"
                        ;;
                *)
                        message="Unknown Error"
                        icon="$icon_err"
                        ;;
        esac
        notification_id=$(date +%s)
        notify-send -a "System" -i "$icon" -r "$notification_id" -u low "Screenshot" "$message" -t $expireTime
}

generate_filename() {
        echo ~/Pictures/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png
}



take_screenshot() {
        local type="$1"
        local filename=$(generate_filename)
        case "$type" in
                all)
                        grim -c -t png "$filename"
                        ;;
                select)
                        grim -c -g "$(slurp)" -t png "$filename"
                        ;;
                *)
                        send_notification error
                        return 1
                        ;;

        esac
        local status=$?
        if [[ $status -eq 0 ]]; then 
                send_notification pic "$filename"
        else
                send_notification error "Screenshot failed with code $status" 
                return 1
        fi
        return 0
}

case "$1" in
        all|select)
                take_screenshot "$1"
                exit $?
                ;;
        *)
                send_notification error "Invalid argument: $1. Use 'all' or 'select'."
                exit 1
                ;;
esac


