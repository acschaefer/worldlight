#!/bin/bash

# Get the path to the worldlight images directory.
SCRIPTDIR="/usr/local/bin/worldlight/scripts"
IMAGEDIR="/usr/local/bin/worldlight/images"

# Retrieve the display size.
DISPSIZE="$(xdpyinfo | awk '/dimensions/{print $2}')"

# Scale the images to fit the display size.
# Check if the images already exist.
if [ -f "${IMAGEDIR}/globe_day.jpg" ]
then
    # Determine the image size.
	IMSIZE=$(identify -format "%wx%h" "${IMAGEDIR}/globe_day.jpg")

    # If the image size does not equal the display size, rescale the images.
    if [ "${IMSIZE}" -ne "${DISPSIZE}" ]; then
        # Scale the globe images to the display resolution.
        convert ${IMAGEDIR}/globe_day_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_day.jpg
        convert ${IMAGEDIR}/globe_night_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_night.jpg
    fi
else
	# Scale the globe images to the display resolution.
    convert ${IMAGEDIR}/globe_day_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_day.jpg
    convert ${IMAGEDIR}/globe_night_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_night.jpg
fi

# Generate the wallpaper.
php ${SCRIPTDIR}/worldlight.php

# Update the wallpaper.
pcmanfm --set-wallpaper ${IMAGEDIR}/worldlight.jpg
