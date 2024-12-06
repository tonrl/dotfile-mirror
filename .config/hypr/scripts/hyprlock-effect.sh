#!/bin/bash

current_hour=$(date +"%H")
user_string="<span color='#b10efb'>$USER</span>"

if [ "$current_hour" -ge 4 ] && [ "$current_hour" -lt 12 ]; then
        echo "Guten Morgen, $user_string!"
elif [ "$current_hour" -ge 12 ] && [ "$current_hour" -lt 18 ]; then
        echo "Guten Tag, $user_string!"
elif [ "$current_hour" -ge 18 ] && [ "$current_hour" -lt 22 ]; then
        echo "Guten Abend, $user_string!"
else
        echo "Gute Nacht, $user_string!"
fi
