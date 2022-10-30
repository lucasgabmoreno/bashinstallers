#!/bin/bash

SOFT_URL=$1
DESK_PATH=$(xdg-user-dir DESKTOP)
APP_PATH=/usr/share/applications/FreeFileSync.desktop
APP_PATH2=/usr/share/applications/RealTimeSync.desktop
SOFT_PACKAGE=freefilesync

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}
mkdir_p() {
if [ ! -e $1 ]; then
    sudo mkdir -p $1
fi
}

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Start count
START_TIME=`date +%s` 

# UNINSTALLER
# Remove old versions and trash

# Close
kill $(pidof FreeFileSync) 2> /dev/null
kill $(pidof FreeFileSync_x86_64) 2> /dev/null
kill $(pidof RealTimeSync) 2> /dev/null
kill $(pidof RealTimeSync_x86_64) 2> /dev/null

# Uninstall
sudo flatpak uninstall org.freefilesync.FreeFileSync* -y 2> /dev/null
sudo bash /opt/FreeFileSync/uninstall.sh 2> /dev/null
sudo apt remove $SOFT_PACKAGE* -y 2> /dev/null
sudo apt purge $SOFT_PACKAGE* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

# Remove trash
sudo rm -rf ~/.config/FreeFileSync* 2> /dev/null
sudo rm -rf /usr/share/applications/FreeFileSync.desktop 2> /dev/null
sudo rm -rf /usr/share/applications/RealTimeSync.desktop 2> /dev/null
sudo rm -rf "$DESK_PATH/FreeFileSync.desktop" 2> /dev/null
sudo rm -rf "$DESK_PATH/RealTimeSync.desktop" 2> /dev/null
sudo rm -rf /usr/share/icons/freefilesync.png 2> /dev/null
sudo rm -rf /usr/share/icons/realtimesync.png 2> /dev/null
sudo rm -rf /usr/share/icons/hicolor/128x128/apps/freefilesync.png 2> /dev/null
sudo rm -rf /usr/share/icons/hicolor/128x128/apps/realtimesync.png 2> /dev/null

if [ ! -e /usr/share/applications/FreeFileSync.desktop ]; then 
echo "Software uninstalled!"
else
echo 'Error!'
fi

# INSTALL

if [ "$SOFT_URL" != "uninstall" ]; then

sudo wget -t inf "https://github.com/lucasgabmoreno/bashinstallers/raw/main/freefilesync/downloads/freefilesync.png"
sudo wget -t inf "https://github.com/lucasgabmoreno/bashinstallers/raw/main/freefilesync/downloads/realtimesync.png"
sudo mv "freefilesync.png" "/usr/share/icons/hicolor/128x128/apps/"
sudo mv "realtimesync.png" "/usr/share/icons/hicolor/128x128/apps/"

sudo wget -t inf "$SOFT_URL"
sudo tar -xf "${SOFT_URL##*/}"
if [ ! -f FreeFileSync*.run ]; then
    sudo curl -L -O "$SOFT_URL"
    sudo tar -xf "${SOFT_URL##*/}"
fi
sudo chmod +x FreeFileSync*.run
sudo ./FreeFileSync*.run 

until [ -f $APP_PATH ]
do
     sleep 1
done

sudo rm -rf "${SOFT_URL##*/}" FreeFileSync*.run

# Final fixes
sudo apt --fix-broken install -y

sudo sed -i 's|Icon=/opt/FreeFileSync/Resources/FreeFileSync.png|Icon=freefilesync|g' $APP_PATH
sudo sed -i 's|Icon=/opt/FreeFileSync/Resources/RealTimeSync.png|Icon=realtimesync|g' $APP_PATH2
chmodown "$APP_PATH"
chmodown "$APP_PATH2"
sudo cp /opt/FreeFileSync/Resources/FreeFileSync.png /usr/share/icons/freefilesync.png
sudo cp /opt/FreeFileSync/Resources/RealTimeSync.png /usr/share/icons/realtimesync.png

sudo rm -rf "$DESK_PATH/FreeFileSync.desktop" 2> /dev/null
sudo rm -rf "$DESK_PATH/RealTimeSync.desktop" 2> /dev/null

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'Error!'
fi # if installed

fi # if not uninstall
fi # if not root
