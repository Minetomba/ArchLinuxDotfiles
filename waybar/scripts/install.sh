#!/bin/bash
action=$(echo -e "Pacman Packages" | rofi -dmenu -i -p "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
    Pacman\ Packages)
        pacman -Ssq | rofi -dmenu -i -p "Packages" | xargs -r -o sudo pacman -S
    ;;
esac