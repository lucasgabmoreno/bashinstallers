#!/bin/bash

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
sudo add-apt-repository ppa:inkscape.dev/stable-1.1 -y
sudo apt-get update -y
sudo apt install inkscape -y

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
APP_PATH=/usr/share/applications/org.inkscape.Inkscape.desktop
chmodown "$APP_PATH"
cp "$APP_PATH" "$DESK_PATH/"   
chmodown "$DESK_PATH/org.inkscape.Inkscape.desktop"

# Final message
if [[ $(sudo apt list inkscape*  2> /dev/null) == *"inkscape"* ]]; then 
sudo echo 'Inkscape installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

