#!/bin/bash

# Set the colors used to structure the console output.
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NOCOLOR='\033[0m' 

# Install PHP in order to be able to run the script that generates the worldlight image.
echo -e "${YELLOW}Installing PHP ...${NOCOLOR}"
sudo apt-get -y install php7.0 php7.0-gd
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to install PHP.${NOCOLOR}"
	exit
fi

# Restart apache in order for PHP to work right away.
echo -e "${YELLOW}Restarting apache ...${NOCOLOR}"
sudo service apache2 restart
if [[ $? > 0 ]]
then
	echo -e "${ORANGE}Warning: failed to restart apache.${NOCOLOR}"
fi

# Install imagemagick in order to scale images to display size.
echo -e "${YELLOW}Installing imagemagick ...${NOCOLOR}"
sudo apt-get -y install imagemagick
if [[ $? > 0 ]]
then
	echo -e "${ORANGE}Warning: failed to install imagemagick.${NOCOLOR}"
fi

# Install all files.
echo -e "${YELLOW}Installing worldlight ...${NOCOLOR}"
INSTALLDIR=/usr/local/bin/worldlight
sudo mkdir -p ${INSTALLDIR}
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to create directory ${INSTALLDIR}.${NOCOLOR}"
	exit
fi
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
MAINDIR=${SCRIPTDIR}/..
sudo rsync -avzh --exclude="install.sh" --exclude="wordlight_original.php" --exclude="worldlight_example.jpg" ${MAINDIR}/scripts ${MAINDIR}/images ${INSTALLDIR}
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to copy directory ${MAINDIR} to ${INSTALLDIR}.${NOCOLOR}"
	exit
fi

# Install worldlight cron job.
echo -e "${YELLOW}Installing worldlight cron job ...${NOCOLOR}"
CRONCMD="/usr/local/bin/worldlight/scripts/worldlight.sh"
CRONJOB="* * * * * ${USER} ${CRONCMD}"
( crontab -l | grep -v -F "$CRONCMD" ; echo "$CRONJOB" ) | crontab -
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to install worldlight cron job.${NOCOLOR}"
	exit
fi

# Return success message.
echo -e "${YELLOW}Worldlight wallpaper script successfully installed.${NOCOLOR}"

