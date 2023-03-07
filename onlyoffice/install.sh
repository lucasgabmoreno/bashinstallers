#!/bin/bash

sudo echo "Start"

SOFT_URL=$1
SOFT_PACKAGE=onlyoffice
SOFT_KILL=DesktopEditors
SOFT_FLATPACK=org.onlyoffice.desktopeditors
DESK_PATH=$(xdg-user-dir DESKTOP) #/home/usernme/Dekstop/
LAUNCHER_PATH="/usr/share/applications/onlyoffice-desktopeditors.desktop"
LAUNCHER_DESK=${LAUNCHER_PATH##*/} #soft.desktop

# Permissions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

# Download and install
wget_dpkg_rm () {
SOFT_URL="$1"
SOFT_DEB=${SOFT_URL##*/}
sudo rm -rf "$SOFT_DEB"* 2> /dev/null
sudo wget -t inf "$SOFT_URL"
if [ ! -f "$SOFT_DEB" ]; then curl -L -O "$SOFT_URL"; fi
sudo mv "$SOFT_DEB" inst.deb
chmodown inst.deb
sudo dpkg -i inst.deb
sudo rm -rf inst.deb
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
sudo rm -rf ~/.config/onlyoffice* 2> /dev/null
sudo rm -rf ~/.local/share/onlyoffice* 2> /dev/null
sudo rm -rf ~/.local/share/applications/Desktopeditors* 2> /dev/null
sudo rm -rf /usr/share/icons/hicolor/onlyoffice-desktopeditors.png 2> /dev/null

# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"* --installed 2> /dev/null) != *"$SOFT_PACKAGE"* ]]; then
    echo "Software uninstalled!"
else
    echo 'Error!'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then

# Dependencies
if [[ $(sudo apt list libnss3 --installed 2> /dev/null) != *"libnss3"* ]]; then 
    sudo apt install libnss3-dev libgdk-pixbuf2.0-dev libgtk-3-dev libxss-dev -y
fi

wget_dpkg_rm "$SOFT_URL"

# Final fixes
sudo apt --fix-broken install -y

# Desktop launcher
sudo cp /usr/share/icons/hicolor/128x128/apps/onlyoffice-desktopeditors.png /usr/share/icons/hicolor/onlyoffice-desktopeditors.png
sudo cp "$LAUNCHER_PATH" "$LAUNCHER_DESK"
chmodown "$LAUNCHER_DESK"
LAUNCHER_DESK_STR=$(paste "$LAUNCHER_DESK")
if [[ "$LAUNCHER_DESK_STR" != *"StartupWMClass"* ]]; then
    sudo sed -i '2 i\StartupWMClass=DesktopEditors' "$LAUNCHER_DESK"
fi # if not StartuoWMClass
sudo sed -i 's|Keywords=Text;|Keywords=Text;winword;excel;powerpnt;|g' "$LAUNCHER_DESK"
sudo rm -rf "$LAUNCHER_PATH" 
sudo mv "$LAUNCHER_DESK" /usr/share/applications/

# Remove trash
sudo rm -rf ~/.local/share/applications/Desktopeditors* 2> /dev/null

# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"* --installed 2> /dev/null) == *"$SOFT_PACKAGE"* ]]; then 
    sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
    echo 'Error!'
fi # if installed

fi # if not uninstall
fi # if not root
