#!/bin/bash
action=$(echo -e "Toggle Wireguard\nReminder\nEmojis\nRecord\nScreenshot" | rofi -dmenu -i -p "Action")
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
        rofimoji --action print | wl-copy
    ;;
    Record)
        ~/.config/waybar/scripts/screenrecorder.sh
    ;;
    Screenshot)
        grim -g "$(slurp)" ~/Pictures/screenshot_$(date +%s).png
        notify-send "Screenshot" "Screenshot saved as screenshot_$(date +%s).png in ~/Pictures/"
    ;;
esac