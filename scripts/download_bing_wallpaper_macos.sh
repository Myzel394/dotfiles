#!/bin/bash

function wallpaper() { 
    desktoppr "$1"
}

echo "Creating folder"
# Create the folder if it doesn't exist
folder=~/Pictures/BingWallpapers
mkdir -p $folder

echo "Getting url"
# Get the Bing picture of the day
wallpaper_path=$(curl 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' -s | rg '(?<="url":")(.*)(?=","urlbase")' -or '$1' --pcre2)
wallpaper_url="https://www.bing.com/$wallpaper_path"
echo "Found url: $wallpaper_url"

# Get the filename
date_formatted=$(date -u +%Y%m%d)
filename="$date_formatted-dummyname.jpg"

echo "Downloading wallpaper to $folder/$filename"
# Download the wallpaper
wget -O $folder/$filename $wallpaper_url -q

echo "Setting wallpaper"
wallpaper $folder/$filename

