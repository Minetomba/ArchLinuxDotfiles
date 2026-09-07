#!/bin/bash
action=$(echo -e "Pacman Packages" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
    Pacman\ Packages)
        pacman -Qqe | wofi --dmenu --prompt "Installed Packages" | xargs -r -o sudo pacman -Rns
    ;;
esac