#!/bin/bash

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}
wget_dpkg_rm () {
sudo wget -t inf "$1/$2"
if [ ! -f "$2" ]; then curl -L -O "$1/$2"; fi
sudo mv "$2" inst.deb
chmodown inst.deb
sudo dpkg -i inst.deb
sudo rm -rf inst.deb
}

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
PATH_CHROME="https://dl.google.com/linux/direct"
CHROME="google-chrome-stable_current_amd64.deb"
wget_dpkg_rm "$PATH_CHROME" "$CHROME"

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
APP_PATH="/usr/share/applications/google-chrome.desktop"
chmodown "$APP_PATH"

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [[ $(sudo apt list --installed google-chrome*  2> /dev/null) == *"google-chrome"* ]]; then 
sudo echo 'Google Chrome installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
