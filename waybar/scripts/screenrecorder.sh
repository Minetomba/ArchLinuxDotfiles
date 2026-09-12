#!/bin/bash
if pgrep -x "wf-recorder" > /dev/null; then
	pkill wf-recorder
	notify-send "Screen Recording" "Recording stopped"
	exit 0
fi
action=$(echo -e "Record region with Audio\nRecord region without Audio" | fuzzel --dmenu --prompt "Action: ")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
	Record\ region\ with\ Audio)
		notify-send "Not yet implemented. Please record audio separately and overlay it with an audioless recording mp4 file"
	;;
	Record\ region\ without\ Audio)
		notify-send "Screen Recording" "Starting recording without audio"
		wf-recorder -g "$(slurp)" -f ~/Videos/recording_$(date +%s).mp4 &
	;;
esac