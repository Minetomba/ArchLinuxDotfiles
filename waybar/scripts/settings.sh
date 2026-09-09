#!/bin/bash
action=$(echo -e "Wireguard Settings\nHyprland Settings\nHyprlock Settings\nMako Settings\nGhostty Settings\nWofi Settings\nTimezone Selector\nBackground" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
	Wireguard\ Settings)
		ghostty -e sudo micro /etc/wireguard/wg0.conf
	;;
	Hyprland\ Settings)
		ghostty -e micro ~/.config/hypr/hyprland.lua
	;;
	Hyprlock\ Settings)
		ghostty -e micro ~/.config/hypr/hyprlock.conf
	;;
	Mako\ Settings)
		ghostty -e micro ~/.config/mako/config
	;;
	Ghostty\ Settings)
		ghostty -e micro ~/.config/ghostty/config.ghostty
	;;
	Wofi\ Settings)
		notify-send "Settings" "Not implemented yet."
	;;
	Timezone\ Selector)
		ghostty -e ~/.config/waybar/scripts/timezones.sh
	;;
	Background)
		target_path=$(wofi --dmenu --prompt "File path (PNG)" --lines 1)
		if [ -z "$target_path" ]; then
			notify-send "Background" "File does not exist."
			exit 1
		fi
		if file "$target_path" | grep -q "PNG image"; then
			sudo cp "$target_path" $HOME/.config/hypr/background.png
			notify-send "Background" "Background succesfully applied (log out and log back in to apply)."
		else
			notify-send "Background" "File must be PNG."
			exit 1
		fi
	;;
esac