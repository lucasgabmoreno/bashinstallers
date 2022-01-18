#!/bin/bash

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
APP_VERSION="1.9.2"
wget_dpkg_rm () {
sudo wget -t inf "$1/$2"
sudo dpkg -i "$2"
sudo rm -rf "$2"
}
wget_dpkg_rm "https://github.com/Foundry376/Mailspring/releases/download/"$APP_VERSION "mailspring-"$APP_VERSION"-amd64.deb"
sudo apt --fix-broken install -y

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
APP_PATH="/usr/share/applications/Mailspring.desktop"
sudo chmod +x $APP_PATH
cp $APP_PATH "$DESK_PATH/"
sudo chmod +x "$DESK_PATH/"Mailspring.desktop

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'Mailspring installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
