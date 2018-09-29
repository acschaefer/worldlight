#!/bin/bash

# Set the colors used to structure the console output.

Black        0;30     Dark Gray     1;30
Red          0;31     Light Red     1;31
Green        0;32     Light Green   1;32
Brown/Orange 0;33     Yellow        1;33
Blue         0;34     Light Blue    1;34
Purple       0;35     Light Purple  1;35
Cyan         0;36     Light Cyan    1;36
Light Gray   0;37     White         1;37

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "I ${RED}love${NC} Stack Overflow"

# Install PHP in order to be able to run the script that generates the worldlight image.
sudo apt-get install php7.0-gd

# Get the path to the worldlight directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Add 
echo 'update_wallpaper.sh' >> /etc/rc.local
