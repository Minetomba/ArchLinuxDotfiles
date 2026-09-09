#!/bin/bash
profiles=("performance" "balanced" "power-saver")
options=()
for profile in "${profiles[@]}"; do
	if [ "$profile" = "$(powerprofilesctl get)" ]; then
		options+=("[-] $profile")
	else
		options+=("[ ] $profile")
	fi
done

selected=$(printf "%s\n" "${options[@]}" | wofi --dmenu --prompt "Power Profile")
if [ -n "$selected" ]; then
	profile=$(echo "$selected" | sed 's/^\[.\] //')
	if [[ " ${profiles[@]} " =~ " $profile " ]]; then
		powerprofilesctl set "$profile"
		notify-send "Power Profile" "Switched to $profile"
	fi
fi