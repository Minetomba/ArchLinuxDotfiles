#!/bin/bash
action=$(echo -e "Set reminder\nRemove reminder" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
	Set\ reminder)
		time_=$(echo "" | wofi --show dmenu -p "Time (MMDDhhmm)" -D use_search_box=false --lines 1)
		if [ -z "$time_" ]; then
			exit 1
		fi
		title=$(echo "" | wofi --show dmenu -p "Title" -D use_search_box=false --lines 1)
		if [ -z "$title" ]; then
			exit 1
		fi
		description=$(echo "" | wofi --show dmenu -p "Description" -D use_search_box=false --lines 1)
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
		done | wofi --dmenu --prompt "Select ID")
		if [ -n "$selection" ]; then
			atrm "${selection%% *}"
			notify-send "Reminders" "Reminder ${selection%% *} removed"
		fi
	;;
esac