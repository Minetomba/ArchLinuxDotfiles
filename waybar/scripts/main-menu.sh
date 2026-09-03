#!/bin/bash
action=$(echo -e "Apps\nWiFi Configuration\nBluetooth Configuration\nPower Profiles\nTimezone\nInstall\nRemove\nTrigger\nSettings\nPower Menu" | rofi -dmenu -i -p "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
    Apps)
        rofi -show drun
    ;;
    WiFi\ Configuration)
        ~/.config/waybar/scripts/wifi.sh
    ;;
    Bluetooth\ Configuration)
        ~/.config/waybar/scripts/bluetooth.sh
    ;;
    Power\ Profiles)
        ~/.config/waybar/scripts/power-profiles.sh
    ;;
    Timezone)
        ~/.config/waybar/scripts/timezones.sh
    ;;
    Install)
        ghostty -e ~/.config/waybar/scripts/install.sh
    ;;
    Remove)
        ghostty -e ~/.config/waybar/scripts/remove.sh
    ;;
    Trigger)
        ~/.config/waybar/scripts/trigger.sh
    ;;
    Settings)
        ~/.config/waybar/scripts/settings.sh
    ;;
    Power\ Menu)
        ~/.config/waybar/scripts/power-menu.sh
    ;;
esac
