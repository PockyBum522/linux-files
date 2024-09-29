#!/bin/bash

export DISPLAY=:0

# Script to randomly set Background from files in a directory

# Directory Containing Pictures
DIR="/media/secondary/seafile-libraries/Wallpapers/Single Screen/4k/Dark Only"

# Command to Select a random jpg file from directory
# Delete the *.jpg to select any file but it may return a folder
PIC=$(ls "$DIR" | shuf -n 1)

echo "$PIC"

# Command to set Background Image
/usr/bin/feh --bg-fill "$DIR/$PIC"
