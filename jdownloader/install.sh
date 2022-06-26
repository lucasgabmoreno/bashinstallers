#!/bin/bash

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install dependencies
sudo apt-get install megatools -y

# Install
megadl --print-names 'https://mega.nz/#!bZtTnSDL!nVnOHuT8LMvvB9EuXp1nrEvjKjzQ6lSRShKkyGNRYPo'
sudo bash JDownloader*sh
sudo rm -rf JDownloader*sh

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
APP_PATH=/usr/share/applications/*JDownloader2.desktop
sudo sed -i 's|Icon=/opt/jd2/.install4j/JDownloader2.png|Icon=jdownloader|g' $APP_PATH
chmodown $APP_PATH
APP_PATH_STR=$(paste $APP_PATH)
if [[ "$APP_PATH_STR" != *"StartupWMClass"* ]]; then
    sudo echo "StartupWMClass=JDownloader" >> $APP_PATH
fi
sudo cp "/opt/jd2/.install4j/JDownloader2.png" /usr/share/icons/jdownloader.png

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [ -e "$APP_PATH" ]; then 
sudo echo 'JDownloader  installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi

