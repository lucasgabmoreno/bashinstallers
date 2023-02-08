#!/bin/bash

sudo echo "Start"

SOFT_URL=$1
SOFT_PACKAGE='/usr/local/bin/slingscold'
SOFT_KILL=slingscold
DESK_PATH=$(xdg-user-dir DESKTOP) #/home/usernme/Dekstop/
LAUNCHER_PATH="/usr/share/applications/slingscold.desktop"
LAUNCHER_DESK=${LAUNCHER_PATH##*/} #soft.desktop

# Permissions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

if [ $USER == "root" ]; then
echo "Don't run as root user"
else

# Start count
START_TIME=`date +%s` 


# UNINSTALLER
# Remove old versions and trash

# Close
kill $(pidof "$SOFT_KILL") 2> /dev/null

# Remove trash
sudo rm -rf "$DESK_PATH/$LAUNCHER_DESK" 2> /dev/null
sudo rm -rf "$LAUNCHER_PATH"
sudo rm -rf "$SOFT_PACKAGE"

# Final message
if [ ! -e "$SOFT_PACKAGE" ]; then 
    echo "Software uninstalled!"
else
    echo 'Error!'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then

# Dependencies
sudo apt-get install cmake libgee-0.8-dev libgnome-menu-3-dev cdbs valac libvala-*-dev libglib2.0-dev libwnck-3-dev libgtk-3-dev git build-essential -y

# Final fixes
sudo apt --fix-broken install -y

git clone $SOFT_URL
cd slingscold
cd build
cmake ..
make
sudo make install
sudo rm -rf "$(xdg-user-dir)/slingscold"

# Final message
if [ -e "$SOFT_PACKAGE" ]; then 
    sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
    sudo echo  'If not working please reboot!'
else
    echo 'Error!'
fi # if installed

fi # if not uninstall
fi # if not root
