#!/bin/bash

# Get the path to the worldlight images directory.
SCRIPTDIR="/usr/local/bin/worldlight/scripts"
IMAGEDIR="/usr/local/bin/worldlight/images"

# Retrieve the display size.
DISPSIZE="$(xdpyinfo | awk '/dimensions/{print $2}')"

# Scale the globe images to the display resolution.
convert ${IMAGEDIR}/globe_day_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_day.jpg
convert ${IMAGEDIR}/globe_night_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_night.jpg

# Update the wallpaper.
pcmanfm --set-wallpaper ${IMAGEDIR}/worldlight.jpg
