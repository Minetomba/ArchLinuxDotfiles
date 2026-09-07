#!/bin/bash
if pgrep -f "$HOME/.config/waybar/scripts/bluetooth.sh" | grep -v $$ > /dev/null; then
	echo "Another instance of bluetooth.sh is already running."
	exit 1
fi
notify-send "Bluetooth" "Please wait a few seconds while the scan is running and a menu will appear of devices to choose from."
bluetoothctl power on >/dev/null 2>&1
declare -A devices
declare -A paired
coproc BTCTL { bluetoothctl; }
printf 'scan on\n' >&"${BTCTL[1]}"
end=$((SECONDS + 5))
while (( SECONDS < end )); do
	if IFS= read -r -t 1 line <&"${BTCTL[0]}"; then
		if [[ "$line" =~ \[NEW\]\ Device\ ([0-9A-F:]{17})\ (.*) ]]; then
			mac="${BASH_REMATCH[1]}"
			name="${BASH_REMATCH[2]}"
			devices["$mac"]="$name"
		fi
		if [[ "$line" =~ \[CHG\]\ Device\ ([0-9A-F:]{17})\ Name:\ (.*) ]]; then
			mac="${BASH_REMATCH[1]}"
			name="${BASH_REMATCH[2]}"
			devices["$mac"]="$name"
		fi
	fi
done
printf 'scan off\n' >&"${BTCTL[1]}"
printf 'exit\n' >&"${BTCTL[1]}"
while read -r _ mac name; do
	[[ -z "$mac" ]] && continue
	devices["$mac"]="$name"
done < <(bluetoothctl devices)
for mac in "${!devices[@]}"; do
	if bluetoothctl info "$mac" 2>/dev/null |
		grep -q "Paired: yes"; then
		paired["$mac"]=1
	fi
done
declare -A entries
menu=""
for mac in "${!devices[@]}"; do
	[[ -z "${paired[$mac]}" ]] && continue
	name="${devices[$mac]}"
	if bluetoothctl info "$mac" 2>/dev/null |
		grep -q "Connected: yes"; then
		status="●"
	else
		status="○"
	fi
	display="$status  $name ($mac)"
	entries["$display"]="$mac"
	menu+="$display"$'\n'
done
for mac in "${!devices[@]}"; do
	[[ -n "${paired[$mac]}" ]] && continue
	name="${devices[$mac]}"
	display="◇  $name ($mac)"
	entries["$display"]="$mac"
	menu+="$display"$'\n'
done
if [[ -z "$menu" ]]; then
	notify-send "Bluetooth" "No devices found."
	exit 1
fi
selection=$(printf '%s' "$menu" | tac | wofi --dmenu --prompt "Bluetooth")
[[ -z "$selection" ]] && exit 0
mac="${entries[$selection]}"
if [[ -z "$mac" ]]; then
	notify-send "Bluetooth" "Could not determine selected device."
	exit 1
fi
name="${devices[$mac]}"
if bluetoothctl info "$mac" 2>/dev/null |
	grep -q "Connected: yes"; then
	if bluetoothctl disconnect "$mac" >/dev/null 2>&1; then
		notify-send "Bluetooth" "Disconnected from $name"
		bluetoothctl power off >/dev/null 2>&1
		pkill -RTMIN+2 waybar
	else
		notify-send "Bluetooth" "Failed to disconnect from $name"
		exit 1
	fi
	exit 0
fi
if ! bluetoothctl info "$mac" 2>/dev/null |
	grep -q "Paired: yes"; then
	notify-send "Bluetooth" "Pairing with $name..."
	if ! bluetoothctl pair "$mac" >/dev/null 2>&1; then
		notify-send "Bluetooth" "Failed to pair with $name"
		exit 1
	fi
fi
notify-send "Bluetooth" "Connecting to $name..."
if bluetoothctl connect "$mac" >/dev/null 2>&1; then
	notify-send "Bluetooth" "Connected to $name"
	pkill -RTMIN+2 waybar
else
	notify-send "Bluetooth" "Failed to connect to $name"
	exit 1
fi