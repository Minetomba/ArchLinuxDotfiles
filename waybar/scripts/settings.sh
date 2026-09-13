#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only
action=$(echo -e "Wireguard Settings\nHyprland Settings\nHyprlock Settings\nMako Settings\nGhostty Settings\nTimezone Selector\nBackground" | fuzzel --dmenu --prompt "Action: ")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
	Wireguard\ Settings)
		ghostty -e sudo vim /etc/wireguard/wg0.conf
	;;
	Hyprland\ Settings)
		ghostty -e vim ~/.config/hypr/hyprland.lua
	;;
	Hyprlock\ Settings)
		ghostty -e vim ~/.config/hypr/hyprlock.conf
	;;
	Mako\ Settings)
		ghostty -e vim ~/.config/mako/config
	;;
	Ghostty\ Settings)
		ghostty -e vim ~/.config/ghostty/config.ghostty
	;;
	Timezone\ Selector)
		ghostty -e ~/.config/waybar/scripts/timezones.sh
	;;
	Background)
		sudo cp "$(fuzzel --dmenu --prompt 'Image path: ')" ~/.config/hypr/background.png
		pkill swaybg || setsid -f swaybg -i ~/.config/hypr/background.png -m fill < /dev/null > /dev/null 2>&1
		notify-send "Background" "Background applied."
	;;
esac