#!/bin/bash

### BEGIN INIT INFO
# Provides:          update_wallpaper.sh
# Required-Start:    $remote_fs $syslog $time
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Worldlight wallpaper update service
# Description:       Updates the worldlight wallpaper every minute.
### END INIT INFO

# Get the path to the worldlight images directory.
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
IMAGEDIR="${SCRIPTDIR}/../images"

# Retrieve the display size.
DISPSIZE="$(xdpyinfo | awk '/dimensions/{print $2}')"

# Scale the globe images to the display resolution.
convert ${IMAGEDIR}/globe_day_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_day.jpg
convert ${IMAGEDIR}/globe_night_original.jpg -resize $DISPSIZE ${IMAGEDIR}/globe_night.jpg

# Update the wallpaper every minute.
while :
do
    php ${SCRIPTDIR}/worldlight.php
    pcmanfm --set-wallpaper ${IMAGEDIR}/worldlight.jpg
    sleep 1m
done

