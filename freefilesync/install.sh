#!/bin/bash

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
VERSION="FreeFileSync_11.16"
FREEFILESYNC=$VERSION"_Linux.tar.gz"
FREEFILESYNC_RUN=$VERSION"_Install.run"
sudo wget -t inf "https://freefilesync.org/download/$FREEFILESYNC"
if [ ! -f "$FREEFILESYNC" ]; then
    curl -O "https://freefilesync.org/download/$FREEFILESYNC"
fi
sudo tar -xf "$FREEFILESYNC"
sudo chmod +x "$FREEFILESYNC_RUN"
sudo ./$FREEFILESYNC_RUN
sudo rm -rf "$FREEFILESYNC_RUN" "$FREEFILESYNC"

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
DESK_TRUE=0
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}
if [ -e "$DESK_PATH/FreeFileSync.desktop" ]; then DESK_TRUE=1; fi
if [ "$DESK_TRUE" == 1 ]; then
sudo rm -rf "$DESK_PATH/FreeFileSync.desktop"
sudo rm -rf "$DESK_PATH/RealTimeSync.desktop"
fi
if [ -e ~/FreeFileSync/ ]; then 
APP_PATH=~/.local/share/applications/FreeFileSync.desktop
APP_PATH2=~/.local/share/applications/RealTimeSync.desktop
sudo sed -i 's|Icon=/home/.*/FreeFileSync/Resources/FreeFileSync.png|Icon=freefilesync|g' $APP_PATH
sudo sed -i 's|Icon=/home/.*/FreeFileSync/Resources/RealTimeSync.png|Icon=realtimesync|g' $APP_PATH2
chmodown "$APP_PATH"
chmodown "$APP_PATH2"
cp ~/FreeFileSync/Resources/FreeFileSync.png ~/.local/share/icons/freefilesync.png
cp ~/FreeFileSync/Resources/RealTimeSync.png ~/.local/share/icons/realtimesync.png
    if [ "$DESK_TRUE" == 1 ]; then
    sudo cp $APP_PATH "$DESK_PATH/"
    sudo cp $APP_PATH2 "$DESK_PATH/"
    chmodown "$DESK_PATH/FreeFileSync.desktop"
    chmodown "$DESK_PATH/RealTimeSync.desktop"
    fi
fi
if [ -e /opt/FreeFileSync ]; then
APP_PATH=/usr/share/applications/FreeFileSync.desktop
APP_PATH2=/usr/share/applications/RealTimeSync.desktop
sudo sed -i 's|Icon=/opt/FreeFileSync/Resources/FreeFileSync.png|Icon=freefilesync|g' $APP_PATH
sudo sed -i 's|Icon=/opt/FreeFileSync/Resources/RealTimeSync.png|Icon=realtimesync|g' $APP_PATH2
chmodown "$APP_PATH"
chmodown "$APP_PATH2"
sudo cp /opt/FreeFileSync/Resources/FreeFileSync.png /usr/share/icons/freefilesync.png
sudo cp /opt/FreeFileSync/Resources/RealTimeSync.png /usr/share/icons/realtimesync.png
    if [ "$DESK_TRUE" == 1 ]; then
    sudo cp $APP_PATH "$DESK_PATH/"
    sudo cp $APP_PATH2 "$DESK_PATH/"
    chmodown "$DESK_PATH/FreeFileSync.desktop"
    chmodown "$DESK_PATH/RealTimeSync.desktop"
    fi
fi
if [ "$DESK_TRUE" == 1 ]; then
    chmodown "$DESK_PATH/FreeFileSync.desktop"
    chmodown "$DESK_PATH/RealTimeSync.desktop"
fi

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'FreeFileSync installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi
