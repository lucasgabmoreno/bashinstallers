#!/bin/bash

SOFT_URL=$1
SOFT_PACKAGE=blender
SOFT_KILL=blender
SOFT_FLATPACK=org.blender.Blender
DESK_PATH=$(xdg-user-dir DESKTOP) #/home/usernme/Dekstop/
LAUNCHER_PATH="/usr/share/applications/blender.desktop"
LAUNCHER_DESK=${LAUNCHER_PATH##*/} #soft.desktop
HICOLOR="https://github.com/lucasgabmoreno/bashinstallers/raw/main/blender/blender.png"
USER_PATH=$(xdg-user-dir)

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
kill $(pidof "$SOFT_KILL") 2> /dev/null

# Uninstall
sudo apt remove "$SOFT_PACKAGE"* -y 2> /dev/null
sudo apt purge "$SOFT_PACKAGE"* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall "$SOFT_FLATPACK"* -y 2> /dev/null

# Remove trash
sudo rm -rf "/usr/share/icons/hicolor/128x128/apps/${HICOLOR##*/}" 2> /dev/null
sudo rm -rf "~/blender" 2> /dev/null
sudo rm -rf $LAUNCHER_PATH 2> /dev/null
sudo rm -rf "~/.local/share/icons/blender.svg"  2> /dev/null
sudo rm -rf "~/.config/blender" 2> /dev/null
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/blender.desktop" 2> /dev/null

if [ ! -e ~/.local/share/applications/blender.desktop ]; then 
echo "Software uninstalled!"
else
echo 'Error'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then

# Install
sudo wget -t inf "$HICOLOR"
sudo cp ${HICOLOR##*/} "/usr/share/icons/hicolor/128x128/apps/"
sudo rm -rf ${HICOLOR##*/} 

sudo wget -t inf "$SOFT_URL"

if [ ! -f ${SOFT_URL##*/} ]; then
    sudo curl -L -O "$SOFT_URL"
fi

sudo mkdir ~/"$SOFT_PACKAGE"
sudo tar -Jxf ${SOFT_URL##*/} --strip-components=1 -C ~/"$SOFT_PACKAGE"
sudo rm -rf ${SOFT_URL##*/}

# Create desktop launcher
sudo sed -i "s|Exec=blender|Exec=$USER_PATH/blender/blender|g" ~/"$SOFT_PACKAGE"/"$LAUNCHER_DESK"
chmodown ~/"$SOFT_PACKAGE"/"$LAUNCHER_DESK"
sudo cp ~/"$SOFT_PACKAGE"/"$LAUNCHER_DESK" /usr/share/applications/
sudo cp ~/blender/blender.svg /usr/share/icons/
chmodown "$LAUNCHER_PATH"


# Final message
if [ -e "$USER_PATH/blender/blender" ]; then 
sudo echo 'Blender installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'Error'
fi

fi

