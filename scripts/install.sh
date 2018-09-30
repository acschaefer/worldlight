#!/bin/bash

# Set the colors used to structure the console output.
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NOCOLOR='\033[0m' 

# Install PHP in order to be able to run the script that generates the worldlight image.
echo -e "${YELLOW}Installing PHP ...${NOCOLOR}"
sudo apt-get install php7.0
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to install PHP.${NOCOLOR}"
	exit
fi

# Restart apache.
echo -e "${YELLOW}Restarting apache ...${NOCOLOR}"
sudo service apache2 restart
if [[ $? > 0 ]]
then
	echo -e "${ORANGE}Error: failed to restart apache.${NOCOLOR}"
fi

# Install imagemagick in order to scale images to display size.
echo -e "${YELLOW}Installing imagemagick ...${NOCOLOR}"
sudo apt-get install imagemagick
if [[ $? > 0 ]]
then
	echo -e "${ORANGE}Error: failed to install imagemagick.${NOCOLOR}"
fi

# Get the path to the worldlight scripts directory.
echo -e "${YELLOW}Retrieving path to images ...${NOCOLOR}"
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to retrieve path to images.${NOCOLOR}"
	exit
fi

# Install all files.
echo -e "${YELLOW}Installing worldlight ...${NOCOLOR}"
INSTALLDIR=/usr/local/bin/worldlight
mkdir ${INSTALLDIR}
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to create directory ${INSTALLDIR}.${NOCOLOR}"
	exit
fi
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
MAINDIR=${SCRIPTDIR}/..
cp ${MAINDIR}/ ${INSTALLDIR}/
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to copy directory ${MAINDIR} to ${INSTALLDIR}.${NOCOLOR}"
	exit
fi

# Set up the worldlight service.
echo -e "${YELLOW}Setting up worldlight service ...${NOCOLOR}"
sudo mv ${SCRIPTDIR}/worldlight.sh /etc/init.d/ && sudo chmod +x /etc/init.d/worldlight.sh
if [[ $? > 0 ]]
then
	echo -e "${RED}Error: failed to copy scripts/worldlight.sh to /etc/init.d.${NOCOLOR}"
	exit
fi

# Update the system init script.
echo -e "${YELLOW}Updating the system init script ...${NOCOLOR}"
sudo update-rc.d worldlight.sh defaults
if [[ $? > 0 ]]
then
	echo -e "${ORANGE}Warning: failed to update the system init script.${NOCOLOR}"
fi

# Start the wallpaper update service.
echo -e "${YELLOW}Starting the wallpaper update service ...${NOCOLOR}"
service worldlight start
if [[ $? > 0 ]]
then
	echo -e "${ORANGE}Warning: failed to start the wallpaper update service.${NOCOLOR}"
fi

# Disable screen blanking.
echo -e "${YELLOW}Disabling screen blanking ...${NOCOLOR}"
XCMD="xserver-command=X -s 0 dpms"
sudo sed -i "/xserver-command=X -s 0 dpms/d" /etc/lightdm/lightdm.conf
echo "xserver-command=X -s 0 dpms" | sudo tee -a /etc/lightdm/lightdm.conf
if [[ $? > 0 ]]
then
	echo -e "${ORANGE}Warning: failed to disable screen blanking.${NOCOLOR}"
fi

# Return success message.
echo -e "${YELLOW}Worldlight wallpaper script successfully installed.${NOCOLOR}"

