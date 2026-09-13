#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only
timezone=$(timedatectl list-timezones | fuzzel --dmenu --prompt "Select Timezone: ")
[ -n "$timezone" ] && sudo timedatectl set-timezone "$timezone"