#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only
action=$(echo -e "Pacman Packages" | fuzzel --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
	Pacman\ Packages)
		pacman -Ssq | fuzzel --dmenu --prompt "Packages" | xargs -r -o sudo pacman -S
	;;
esac