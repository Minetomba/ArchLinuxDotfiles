#!/bin/bash
action=$(echo -e "Set reminder\nRemove reminder" | fuzzel --dmenu --prompt "Action: ")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
	Set\ reminder)
		time_=$(fuzzel --dmenu -p "Time (MMDDhhmm): ")
		if [ -z "$time_" ]; then
			exit 1
		fi
		title=$(fuzzel --dmenu -p "Title: ")
		if [ -z "$title" ]; then
			exit 1
		fi
		description=$(fuzzel --dmenu -p "Description: ")
		if [ -z "$description" ]; then
			exit 1
		fi
		echo "notify-send \"$title\" \"$description\"" | at -t "$time_"
		notify-send "Reminders" "Reminder set at $time_"
	;;
	Remove\ reminder)
		selection=$(atq | while read -r id rest; do
			title=$(at -c "$id" | grep -oP 'notify-send\s+["'\'']\K[^"'\'']+' | head -n 1)
			title=${title:-"No Title Found"}
			echo "[$id] > $title"
		done | fuzzel --dmenu --prompt "Select ID")
		if [ -n "$selection" ]; then
			atrm "${selection%% *}"
			notify-send "Reminders" "Reminder ${selection%% *} removed"
		fi
	;;
esac