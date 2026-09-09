#!/bin/bash
action=$(echo -e "Apps\nWiFi Configuration\nBluetooth Configuration\nPower Profiles\nInstall\nRemove\nKeybindings\nTrigger\nSettings\nPower Menu" | wofi --dmenu --prompt "Action")
if [ -z "$action" ]; then
	exit 1
fi
sleep 0.1
case "$action" in
	Apps)
		wofi --show drun
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
	Install)
		ghostty -e ~/.config/waybar/scripts/install.sh
	;;
	Remove)
		ghostty -e ~/.config/waybar/scripts/remove.sh
	;;
	Keybindings)
		echo -e "XF86AudioRaiseVolume > Raise volume by 5%\nXF86AudioLowerVolume > Lower volume by 5%\nXF86AudioMute > Mute audio\nXF86AudioMicMute > Mute microphone\nXF86MonBrightnessUp > Raise screen brightness by 5%\nXF86MonBrightnessDown > Lower screen brightness by 5%Shift + XF86MonBrightnessUp > Set screen brightness to 100%\nShift + XF86MonBrightnessDown > Set screen brightness to 0%\nXF86KbdBrightnessUp > Increase keyboard backlight\nXF86KbdBrightnessDown > Decrease keyboard backlight\nXF86KbdLightOnOff > Cycle keyboard backlight\nAlt + XF86AudioRaiseVolume > Increase audio volume by 1%\nAlt + XF86AudioLowerVolume > Decrease audio volume by 1%\nAlt + XF86MonBrightnessUp > Increase screen brightness by 1%\nAlt + XF86MonBrightnessDown > Decrease screen brightness by 1%\nXF86AudioPlay > Play/Pause media\nXF86AudioNext > Next media\nXF86AudioPrev > Previous media\nSuper + C > Universal copy\nSuper + V > Universal paste\nSuper + X > Universal cut\nSuper + W > Close window\nSuper + J > Cycle horizontal/vertical window placement\nSuper + P > Pseudo tiling\nSuper + T > Cycle floating/tiled window\nSuper + F > Make window fullscreen/revert to original size\nSuper + Left arrow > Change focus left\nSuper + Right arrow > Change focus right\nSuper + Up arrow > Change focus up\nSuper + Down arrow > Change focus down\nSuper + 0-9 > Change to that workspace\nSuper + Shift + 0-9 > Move window to that workspace\nSuper + Shift + Alt + 0-9 > Move window to that workspace silently\nSuper + S > Toggle scratchpad\nSuper + Shift + S > Move window to scratchpad workspace\nSuper + Tab > Change to next workspace\nSuper + Shift + Tab > Change to previous workspace\nSuper + Ctrl + Tab > Change to former workspace\nSuper + Shift + Alt + Left arrow > Move workspace to left monitor\nSuper + Shift + Alt + Right arrow > Move workspace to right monitor\nSuper + Shift + Alt + Up arrow > Move workspace to upper monitor\nSuper + Shift + Alt + Down arrow > Move workspace to lower monitor\nSuper + Shift + Left arrow > Move window left\nSuper + Shift + Right arrow > Move window right\nSuper + Shift + Up arrow > Move window up\nSuper + Shift + Down arrow > Move window down\nSuper + Drag > Resize window\nSuper + Alt + Space > Open main menu\nSuper + Space > Open apps menu\nSuper + Q > Open terminal\nSuper + E > Open emoji selector menu\nSuper + R > Open reminder menu\nXF86PowerOff > Open power menu\nXF86Calculator > Open calculator\nSuper + Shift + Space > Toggle waybar\nSuper + Comma > Dismiss latest notification\nSuper + Shift + Comma > Dismiss all notifications\nSuper + Ctrl + Comma > Cycle do-not-disturb notification mode\nSuper + Alt + Comma > Invoke last dismissed notification\nSuper + Shift + Alt + Comma > Restore last dismissed notification\nPrint > Take a screenshot with region selection\nSuper + Print > Open color picker\nAlt + Print > Open the screenrecording menu\nSuper + L > Lock" | wofi --dmenu --prompt "Keybindings"
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
