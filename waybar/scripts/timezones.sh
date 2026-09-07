#!/bin/bash
timezone=$(timedatectl list-timezones | wofi --dmenu --prompt "Select Timezone")
[ -n "$timezone" ] && sudo timedatectl set-timezone "$timezone"