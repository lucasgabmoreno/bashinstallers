#!/bin/bash

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

# Remove old versions and trash
bash uninstall.sh noremove

# Install
sudo wget -t inf "https://github.com/lucasgabmoreno/bashinstallers/raw/main/freefilesync/freefilesync.png"
sudo wget -t inf "https://github.com/lucasgabmoreno/bashinstallers/raw/main/freefilesync/realtimesync.png"
sudo cp "freefilesync.png" "/usr/share/icons/hicolor/128x128/apps/"
sudo cp "realtimesync.png" "/usr/share/icons/hicolor/128x128/apps/"
mkdir_p ~/.local/share/applications/
mkdir_p ~/.local/share/icons/
VERSION="11.16"
FREEFILESYNC="FreeFileSync_"$VERSION"_Linux.tar.gz"
FREEFILESYNC_RUN="FreeFileSync_"$VERSION"_Install.run"
sudo wget -t inf "https://freefilesync.org/download/$FREEFILESYNC"
if [ ! -f "$FREEFILESYNC" ]; then curl -L -O "https://freefilesync.org/download/$FREEFILESYNC"; fi
sudo tar -xf "$FREEFILESYNC"
sudo chmod +x "$FREEFILESYNC_RUN"
sudo ./$FREEFILESYNC_RUN
sudo rm -rf "$FREEFILESYNC_RUN" "$FREEFILESYNC"

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/FreeFileSync.desktop" 2> /dev/null
sudo rm -rf "$DESK_PATH/RealTimeSync.desktop" 2> /dev/null
    # if HOME
if [ -e ~/FreeFileSync/ ]; then 
APP_PATH=~/.local/share/applications/FreeFileSync.desktop
APP_PATH2=~/.local/share/applications/RealTimeSync.desktop
sudo sed -i 's|Icon=/home/.*/FreeFileSync/Resources/FreeFileSync.png|Icon=freefilesync|g' $APP_PATH
sudo sed -i 's|Icon=/home/.*/FreeFileSync/Resources/RealTimeSync.png|Icon=realtimesync|g' $APP_PATH2
chmodown "$APP_PATH"
chmodown "$APP_PATH2"
sudo cp ~/FreeFileSync/Resources/FreeFileSync.png ~/.local/share/icons/freefilesync.png
sudo cp ~/FreeFileSync/Resources/RealTimeSync.png ~/.local/share/icons/realtimesync.png
fi
    # if ROOT
if [ -e /opt/FreeFileSync ]; then
APP_PATH=/usr/share/applications/FreeFileSync.desktop
APP_PATH2=/usr/share/applications/RealTimeSync.desktop
sudo sed -i 's|Icon=/opt/FreeFileSync/Resources/FreeFileSync.png|Icon=freefilesync|g' $APP_PATH
sudo sed -i 's|Icon=/opt/FreeFileSync/Resources/RealTimeSync.png|Icon=realtimesync|g' $APP_PATH2
chmodown "$APP_PATH"
chmodown "$APP_PATH2"
sudo cp /opt/FreeFileSync/Resources/FreeFileSync.png /usr/share/icons/freefilesync.png
sudo cp /opt/FreeFileSync/Resources/RealTimeSync.png /usr/share/icons/realtimesync.png
fi

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'FreeFileSync installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi

fi
