#!/bin/bash

sudo echo "Start"

SOFT_URL=$1
SOFT_PACKAGE=zotero
SOFT_KILL=zotero
SOFT_FLATPACK=org.zotero.Zotero
DESK_PATH=$(xdg-user-dir DESKTOP) #/home/usernme/Dekstop/
LAUNCHER_PATH="/usr/share/applications/zotero.desktop"
LAUNCHER_DESK=${LAUNCHER_PATH##*/} #soft.desktop

# Permissions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

if [ $USER == "root" ]; then
echo "Don't run as root user"
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
sudo rm -rf "$DESK_PATH/$LAUNCHER_DESK" 2> /dev/null
sudo rm -rf "$LAUNCHER_PATH"
sudo rm -rf ~/Zotero* 2> /dev/null

# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"* --installed 2> /dev/null) != *"$SOFT_PACKAGE"* ]]; then
    echo "Software uninstalled!"
else
    echo 'Error!'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then

wget -qO- "$SOFT_URL" | sudo bash
sudo apt update
sudo apt install zotero

# Final fixes
sudo apt --fix-broken install -y

# Desktop launcher
sudo cp "$LAUNCHER_PATH" "$LAUNCHER_DESK"
chmodown "$LAUNCHER_DESK"
LAUNCHER_DESK_STR=$(paste "$LAUNCHER_DESK")
if [[ "$LAUNCHER_DESK_STR" != *"StartupWMClass"* ]]; then
    sudo sed -i '2 i\StartupWMClass=Zotero' "$LAUNCHER_DESK"
fi # if not StartuoWMClass
sudo sed -i 's|Icon=/usr/lib/zotero/chrome/icons/default/default256.png|Icon=zotero|g' "$LAUNCHER_DESK"
sudo rm -rf "$LAUNCHER_PATH" 
sudo mv "$LAUNCHER_DESK" /usr/share/applications/

# Remove this insaller
sudo rm -rf install.sh

# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"* --installed 2> /dev/null) == *"$SOFT_PACKAGE"* ]]; then 
    sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
    echo 'Error!'
fi # if installed

fi # if not uninstall
fi # if not root
