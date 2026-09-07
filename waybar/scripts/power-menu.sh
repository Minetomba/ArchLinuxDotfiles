#!/bin/bash
action=$(echo -e "Lock\nLog out\nReboot\nPower off" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
    Lock)
        hyprlock
    ;;
    Log\ out)
        loginctl terminate-session $(loginctl session-status | head -1 | awk '{print $1}')
    ;;
    Power\ off)
        systemctl poweroff
    ;;
    Reboot)
        reboot
    ;;
esac
