#!/bin/bash

# Select a random wallpaper
wal -q -i ~/wallpaper/

# Load current pywal color scheme
source "$HOME/.cache/wal/colors.sh"

# Copy selected wallpaper into .cache folder
cp $wallpaper ~/.cache/current_wallpaper.jpg

# get wallpaper iamge name
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# Set the new wallpaper
swww img $wallpaper --transition-step 20 --transition-fps=20
~/.config/waybar/launch.sh
sleep 1

# Send notification
notify-send "Wallpaper and colors updated with image '$newwall'"

