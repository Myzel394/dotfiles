#!/bin/bash
FOLDER=~/Pictures/BingWallpapers

if ! [[ -d "$FOLDER" ]]; then
    FOLDER=~/Pictures/BingWallpaper
fi

# Finds the most recent image in the folder
IMAGE=$(ls "$FOLDER" | sort -k 1,1 -t"-" -n --reverse | head -n 1)

node ~/.config/scripts/set_theme_from_bg.js "$FOLDER/$IMAGE"

