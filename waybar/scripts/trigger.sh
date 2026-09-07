#!/bin/bash
action=$(echo -e "Toggle Wireguard\nReminder\nEmojis\nRecord\nScreenshot" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
    Toggle\ Wireguard)
        ghostty -e ~/.config/waybar/scripts/vpn-toggle.sh
    ;;
    Reminder)
        ~/.config/waybar/scripts/reminder.sh
    ;;
    Emojis)
        rofimoji --selector wofi --action print | tr -d '\n' | wl-copy
    ;;
    Record)
        ~/.config/waybar/scripts/screenrecorder.sh
    ;;
    Screenshot)
        grim -g "$(slurp)" - | wl-copy --type image/png && notify-send "Screenshot" "Screenshot copied to clipboard"
    ;;
esac