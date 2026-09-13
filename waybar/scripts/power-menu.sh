#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only
action=$(echo -e "Lock\nLog out\nReboot\nPower off" | fuzzel --dmenu --prompt "Action: ")
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
