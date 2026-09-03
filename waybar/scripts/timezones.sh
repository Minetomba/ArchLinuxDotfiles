#!/bin/bash
timezone=$(timedatectl list-timezones | rofi -dmenu -i -p "Select Timezone")
[ -n "$timezone" ] && sudo timedatectl set-timezone "$timezone"