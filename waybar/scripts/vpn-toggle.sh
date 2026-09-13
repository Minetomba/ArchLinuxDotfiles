#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only
if ip link show wg0 2>/dev/null | grep -q 'wg0:'; then
	sudo wg-quick down wg0
else
	sudo wg-quick up wg0
fi
pkill -RTMIN+1 waybar