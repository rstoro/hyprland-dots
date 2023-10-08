#!/usr/bin/env bash

# base packages
pacman -Syu base-devel archlinux-keyring git

# get aur pkg manager
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -sri
rm -rf yay-bin

# install additional deps
yay -Syyu hyprland-git waybar-hyprland-git wlr-randr xdg-desktop-portal-hyprland polkit-kde-agent kitty wofi dunst clipman brightnessctl grim slurp starship ranger python-pillow wf-recorder swww pywal pfetch gifski bluez bluez-utils pipewire Networkmanager ttf-jetbrains-mono-nerd ttf-nerd-font-symbols-mono xwaylandvideobridge-cursor-mode-2-git

# personal packages
yay -Syyu neovim curl wget flatpak flatseal

# copy .bashrc
cp .bashrc ~/.bashrc

# copy configurations
cp -r config/* ~/.config/

# copy user scripts
sudo cp -r usr_scripts/* /usr/local/bin/

# make wallpaper directory
mkdir ~/wallpaper
mkdir ~/animated_wallpaper

# TODO: find OCR screencap, configure gui bluetooth/wifi
