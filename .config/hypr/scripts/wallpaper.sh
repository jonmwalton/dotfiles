#!/bin/bash
#                _ _                              
# __      ____ _| | |_ __   __ _ _ __   ___ _ __  
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                   |_|         |_|               
#  
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

monitors=~/.config/hypr/monitors.conf

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"
blurred="$HOME/.cache/blurred_wallpaper.png"
blur="50x30"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/dotfiles/wallpaper/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/dotfiles/wallpaper/default.jpg\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        if [ -f $cache_file ]; then
            wal -q -i $current_wallpaper
        else
            wal -q -i ~/dotfiles/wallpaper/
        fi
    ;;

    # Select wallpaper with rofi
    "select")

        selected=$( find "$HOME/dotfiles/wallpaper" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "$rfile\x00icon\x1f$HOME/dotfiles/wallpaper/${rfile}\n"
        done | rofi -dmenu -replace -config ~/dotfiles/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -q -i ~/dotfiles/wallpaper/$selected
    ;;

    # Randomly select wallpaper 
    *)
        wal -q -i ~/dotfiles/wallpaper/
    ;;

esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo ":: Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# Write selected wallpaper into .cache files
# ----------------------------------------------------- 
echo "$wallpaper" > "$cache_file"
#echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/dotfiles/wallpaper/||g")

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
~/dotfiles/.config/waybar/launch.sh

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

#swww img $wallpaper \
#    --transition-bezier .43,1.19,1,.4 \
#    --transition-fps=60 \
#    --transition-type=$transition_type \
#    --transition-duration=0.7 \
#    --transition-pos "$( hyprctl cursorpos )"
hyprctl hyprpaper preload $wallpaper

for monitor in $(hyprctl monitors | grep 'Monitor' | awk '{ print $2 }'); do

	hyprctl hyprpaper wallpaper "$monitor,$wallpaper"

done


# ----------------------------------------------------- 
# Created blurred wallpaper
# -----------------------------------------------------
magick $wallpaper -resize 75% $blurred
echo ":: Resized to 75%"
if [ ! "$blur" == "0x0" ] ;then
    echo "Blur wallpaper using magick"
    magick $blurred -blur $blur $blurred
    echo "* { current-image: url(\"$blurred\", height); }" > "$rasi_file"
    echo ":: Blurred"
fi


# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    echo "Send notification"
    sleep 1
    notify-send "Colors and Wallpaper updated" "with image $newwall"
fi

echo "DONE!"
