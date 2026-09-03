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