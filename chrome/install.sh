#!/bin/bash

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
PATH_CHROME="https://dl.google.com/linux/direct"
CHROME="google-chrome-stable_current_amd64.deb"
wget_dpkg_rm () {
sudo wget -t inf "$1/$2"
sudo dpkg -i "$2"
sudo rm -rf "$2"
}
wget_dpkg_rm "$PATH_CHROME" "$CHROME"

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
APP_PATH="/usr/share/applications/google-chrome.desktop"
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}
chmodown "$APP_PATH"
sudo cp $APP_PATH "$DESK_PATH/"
chmodown "$DESK_PATH/google-chrome.desktop"


# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'Google Chrome installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
