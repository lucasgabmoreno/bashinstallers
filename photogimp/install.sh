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

# Install
sudo apt-get install gimp -y
sudo apt --fix-broken install -y
PHOTOGIMP="PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip"
sudo wget -t inf "https://github.com/Diolinux/PhotoGIMP/releases/download/1.0/$PHOTOGIMP"
sudo unzip "$PHOTOGIMP"
sudo rm -rf "$PHOTOGIMP"
sudo cp -R "PhotoGIMP by Diolinux v2020 for Flatpak/.var/app/org.gimp.GIMP/config/GIMP/2.10/"* ~/.config/GIMP/2.10/
sudo rm -rf "PhotoGIMP by Diolinux v2020 for Flatpak"

# Create desktop launcher
sudo wget -t inf "https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/photogimp/photogimp.png"
sudo cp "photogimp.png" "/usr/share/icons"
sudo cp "photogimp.png" "/usr/share/icons/hicolor/128x128/apps"
sudo rm -rf "photogimp.png"
APP_PATH="/usr/share/applications/gimp.desktop"
sudo sed -i "s|Name=GNU\ Image\ Manipulation\ Program|Name=PhotoGIMP|g" $APP_PATH
sudo sed -i "s|Icon=gimp|Icon=photogimp|g" $APP_PATH
chmodown "$APP_PATH"

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [[ $(sudo apt list --installed gimp*  2> /dev/null) == *"gimp"* ]]; then 
sudo echo 'PhotoGIMP installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
