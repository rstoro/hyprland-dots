# Select a random wallpaper
mkdir -p "$HOME/wallpaper"
wal -q -i "$HOME/wallpaper/"

# Load current pywal color scheme
mkdir -p "$HOME/.cache/wal"
source "$HOME/.cache/wal/colors.sh"

# Copy selected wallpaper into .cache folder
cp $wallpaper ~/.cache/current_wallpaper.jpg

# get wallpaper iamge name
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# Set the new wallpaper
swww img --transition-fps 60 --transition-type outer --transition-pos 0.854,0.977 --transition-step 90 $wallpaper
~/.config/waybar/launch.sh
sleep 1

# Send notification
notify-send "Wallpaper and colors updated with image '$newwall'"

