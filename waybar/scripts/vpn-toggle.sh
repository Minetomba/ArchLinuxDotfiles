#!/bin/bash
if ip link show wg0 2>/dev/null | grep -q 'wg0:'; then
    sudo wg-quick down wg0
else
    sudo wg-quick up wg0
fi
pkill -RTMIN+1 waybar