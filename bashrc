#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only

# If not running in interactive mode, do nothing
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# Start hyprland after logging into TTY1
if [ "$(tty)" = "/dev/tty1" ]; then
		exec start-hyprland
fi

# Command not found
command_not_found_handle() {
	printf '%s\n' "$1" | xargs -r pacman -F
}