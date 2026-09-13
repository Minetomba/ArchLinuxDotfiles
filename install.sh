#!/bin/bash
# SPDX-FileCopyrightText: 2026 Minetomba <minetomba@proton.me>
# SPDX-License-Identifier: GPL-3.0-only
# Once you have a minimal arch linux installation with sudo, systemd, a sudo user, base, base-devel, bash and up-to-date mirrors, you can proceed with this script
# This assumes you are in the directory of this... Wherever it is. Hence why it's using sudo for practically everything because it might be in an USB environment where sudo is required for every file movement. Better safe than crash.
# Also, please run "sudo pacman -Syyu" before this and make sure you're connected to the internet

# Install packages
sudo pacman -S --needed python musl systemd-resolvconf nano fuzzel file less gcc pam busctl curl ffmpeg pavucontrol vim git at hyprlock playerctl wf-recorder power-profiles-daemon swaybg bc nerd-fonts libnotify ttf-roboto iwd iw bluez bluez-utils pipewire wireplumber hyprland waybar mako polkit-gnome ghostty gnome-calculator fzf grim slurp wl-clipboard btop hyprpicker brightnessctl wireguard-tools pipewire-pulse pacman-contrib rofimoji

# Systemctl services
sudo systemctl enable --now atd
sudo systemctl enable --now iwd
sudo systemctl enable --now bluetooth
systemctl --user enable --now pipewire pipewire-pulse

# Make logind configuration
sudo cp logind/logind.conf /etc/systemd/logind.conf

# Make git use vim for everything
git config --global core.editor vim

# Make sure the waybar scripts are executable
sudo chmod +x ./waybar/scripts/*

# Make the "Videos" directory for recordings storage
sudo mkdir -p ~/Videos

# Transfer bashrc
sudo cp bashrc ~/.bashrc

# Make the .config directory
sudo mkdir -p ~/.config

# Transfer the application configs
sudo rm -rf ~/.config/hypr
sudo rm -rf ~/.config/waybar
sudo rm -rf ~/.config/ghostty
sudo rm -rf ~/.config/fuzzel
sudo rm -rf ~/.config/mako

sudo cp -r hypr ~/.config/hypr
sudo cp -r waybar ~/.config/waybar
sudo cp -r ghostty ~/.config/ghostty
sudo cp -r fuzzel ~/.config/fuzzel
sudo cp -r mako ~/.config/mako

# Own the home directory
sudo -E chown -R "$USER:$USER" "$HOME"

# Get in the "input" group
sudo usermod -a -G input $USER

# Display the final message
echo "Install complete!"