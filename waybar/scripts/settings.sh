#!/bin/bash
action=$(echo -e "Wireguard Settings\nHyprland Settings\nHyprlock Settings\nMako Settings\nGhostty Settings\nRofi Settings\nBackground" | rofi -dmenu -i -p "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
    Wireguard\ Settings)
        ghostty -e sudo nano /etc/wireguard/wg0.conf
    ;;
    Hyprland\ Settings)
        ghostty -e nano ~/.config/hypr/hyprland.conf
    ;;
    Hyprlock\ Settings)
        ghostty -e nano ~/.config/hypr/hyprlock.conf
    ;;
    Mako\ Settings)
        ghostty -e nano ~/.config/mako/config
    ;;
    Ghostty\ Settings)
        ghostty -e nano ~/.config/ghostty/config.ghostty
    ;;
    Rofi\ Settings)
        ghostty -e nano ~/.config/rofi/config.rasi
    ;;
    Background)
        target_path=$(rofi -dmenu -p "File path (PNG)" -location 0 -fixed-num-lines 1)
        if [ -z "$target_path" ]; then
            exit 1
        fi
        if file "$target_path" | grep -q "PNG image"; then
            sudo cp "$target_path" $HOME/.config/hypr/background.png
        else
            exit 1
        fi
    ;;
esac