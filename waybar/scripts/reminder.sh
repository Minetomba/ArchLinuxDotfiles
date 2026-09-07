#!/bin/bash
action=$(echo -e "Set reminder\nRemove reminder" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
    Set\ reminder)
        time_=$(wofi --dmenu --prompt "Time (MMDDhhmm):" --lines 1)
        if [ -z "$time_" ]; then
            exit 1
        fi
        title=$(wofi --dmenu --prompt "Title" --lines 1)
        if [ -z "$title" ]; then
            exit 1
        fi
        description=$(wofi --dmenu --prompt "Description" --lines 1)
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