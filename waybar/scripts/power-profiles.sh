#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only
profiles=("performance" "balanced" "power-saver")
options=()
for profile in "${profiles[@]}"; do
	if [ "$profile" = "$(powerprofilesctl get)" ]; then
		options+=("[-] $profile")
	else
		options+=("[ ] $profile")
	fi
done

selected=$(printf "%s\n" "${options[@]}" | fuzzel --dmenu --prompt "Power Profile: ")
if [ -n "$selected" ]; then
	profile=$(echo "$selected" | sed 's/^\[.\] //')
	if [[ " ${profiles[@]} " =~ " $profile " ]]; then
		powerprofilesctl set "$profile"
		notify-send "Power Profile" "Switched to $profile"
	fi
fi