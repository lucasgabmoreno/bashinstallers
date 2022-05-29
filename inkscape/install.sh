#!/bin/bash

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

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
sudo add-apt-repository ppa:inkscape.dev/stable -y
sudo apt-get update -y
sudo apt install inkscape -y

# Final fixes
sudo apt --fix-broken install -y

# If Debian will download AppImage and use it as GUI
if [[ $(gcc --version) == *Debian* ]]; then
USER_PATH=$(xdg-user-dir)
APP_IMAGE=Inkscape-dc2aeda-x86_64.AppImage
APP_IMAGE_URL=https://inkscape.org/es/gallery/item/33450/"$APP_IMAGE"
sudo mkdir ~/inkscape
sudo wget -t inf $APP_IMAGE_URL
sudo mv "$APP_IMAGE" ~/inkscape/Inkscape.AppImage
chmodown ~/inkscape/Inkscape.AppImage
sudo sed -i "s|Exec=inkscape %F|Exec=$USER_PATH/inkscape/Inkscape.AppImage|g" /usr/share/applications/org.inkscape.Inkscape.desktop
fi

# Create desktop launcher
APP_PATH=/usr/share/applications/org.inkscape.Inkscape.desktop
chmodown "$APP_PATH"

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [[ $(sudo apt list --installed inkscape*  2> /dev/null) == *"inkscape"* ]]; then 
sudo echo 'Inkscape installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
