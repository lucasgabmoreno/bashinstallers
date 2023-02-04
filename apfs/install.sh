#!/bin/bash

sudo echo "Start"

SOFT_URL=$1
SOFT_PACKAGE='/usr/bin/apfsutil'

if [ $USER == "root" ]; then
echo "Don't run as root user"
else

# Start count
START_TIME=`date +%s` 

# UNINSTALLER
# Remove

sudo rm -rf /usr/bin/apfs-* 2> /dev/null
sudo rm -rf /usr/bin/apfsutil 2> /dev/null

# Final message
if [ ! -e "$SOFT_PACKAGE" ]; then 
    echo "Software uninstalled!"
else
    echo 'Error!'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then

# Dependencies
sudo apt install fuse libfuse3-dev bzip2 libbz2-dev cmake gcc g++ git libattr1-dev zlib1g-dev -y

# Final fixes
sudo apt --fix-broken install -y

git clone $SOFT_URL
cd apfs-fuse
git submodule init
git submodule update
mkdir build
cd build
cmake ..
make
sudo cp apfs-* /usr/bin/
sudo cp apfsutil /usr/bin/
sudo rm -rf "$(xdg-user-dir)/apfs-fuse"

# Final message
if [ -e "$SOFT_PACKAGE" ]; then 
    sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
    sudo echo  'If not working please reboot!'
else
    echo 'Error!'
fi # if installed

fi # if not uninstall
fi # if not root
