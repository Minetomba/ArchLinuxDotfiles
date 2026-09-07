#!/bin/bash
mapfile -t devices < <(
    for d in /sys/class/net/*; do
        [ -d "$d/wireless" ] && basename "$d"
    done
)
if [ ${#devices[@]} -eq 0 ]; then
	notify-send "Network" "No network devices found"
	exit 1
fi

device_to_use=$(printf "%s\n" "${devices[@]}" | wofi --dmenu --prompt "Select Network Device")
if [ -z "$device_to_use" ]; then
	exit 1
fi

if ! iwctl station "$device_to_use" scan >/dev/null 2>&1; then
	notify-send "Network" "Invalid device: $device_to_use"
	exit 1
fi

action=$(echo -e "Connect\nDisconnect\nCancel" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
case "$action" in
	"Connect")
		mapfile -t networks < <(
			busctl tree net.connman.iwd |
			python -c '
		import sys

		for line in sys.stdin:
			path = line.strip().split("/")[-1]

			if path.endswith("_psk"):
				ssid = path[:-4]
				print(bytes.fromhex(ssid).decode())
		'
		)
		if [ -z "$networks" ]; then
			notify-send "Network" "No networks found"
			exit 1
		fi

		target_network=$(printf '%s\n' "${networks[@]}" | wofi --dmenu --prompt "Select WiFi Network")
		if [ -z "$target_network" ]; then
			exit 1
		fi
		
		wofi --dmenu --password --prompt "WiFi Password (none if open)" | xargs iwctl station "$device_to_use" connect "$target_network" --password
	;;
	"Disconnect")
		iwctl station "$device_to_use" disconnect
		notify-send "Network" "Disconnected $device_to_use"
	;;
esac
