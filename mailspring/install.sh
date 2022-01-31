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

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
MAILSPRING="download?platform=linuxDeb"
MAILSPRING_PATH="https://updates.getmailspring.com"
wget_dpkg_rm "$MAILSPRING_PATH" "$MAILSPRING"

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
APP_PATH="/usr/share/applications/Mailspring.desktop"
chmodown $APP_PATH
cp $APP_PATH "$DESK_PATH/"
chmodown "$DESK_PATH/"Mailspring.desktop

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [[ $(sudo apt list mailspring*  2> /dev/null) == *"mailspring"* ]]; then 
sudo echo 'Mailspring installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
