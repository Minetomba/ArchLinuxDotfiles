#!/bin/bash
timezone=$(timedatectl list-timezones | fuzzel --dmenu --prompt "Select Timezone: ")
[ -n "$timezone" ] && sudo timedatectl set-timezone "$timezone"