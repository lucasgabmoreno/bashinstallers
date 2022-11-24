#!/bin/bash

sudo echo "Start"

SOFT_URL=$1
SOFT_PACKAGE=inkscape
SOFT_KILL=inkscape
SOFT_FLATPACK=org.inkscape.Inkscape
DESK_PATH=$(xdg-user-dir DESKTOP) #/home/usernme/Dekstop/
LAUNCHER_PATH="/usr/share/applications/org.inkscape.Inkscape.desktop"
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
sudo rm -rf ~/.config/inkscape* 2> /dev/null
sudo rm -rf ~/inkscape* 2> /dev/null
sudo rm -rf ~/.var/app/org.inkscape* 2> /dev/null

# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"* --installed 2> /dev/null) != *"$SOFT_PACKAGE"* ]]; then
    echo "Software uninstalled!"
else
    echo 'Error!'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then


if [[ $(gcc --version) == *Ubuntu* ]]; then
sudo add-apt-repository ppa:inkscape.dev/stable -y
sudo apt update -y
fi

sudo apt install inkscape -y

if [[ $(gcc --version) == *Debian* ]]; then
USER_PATH=$(xdg-user-dir)
# https://inkscape.org/release/all/gnulinux/appimage/
sudo mkdir ~/inkscape
sudo wget -t inf $SOFT_URL
sudo mv ${SOFT_URL##*/} ~/inkscape/Inkscape.AppImage
chmodown ~/inkscape/Inkscape.AppImage
fi

# Final fixes
sudo apt --fix-broken install -y

# Desktop launcher
sudo cp "$LAUNCHER_PATH" "$LAUNCHER_DESK"
chmodown "$LAUNCHER_DESK"
if [[ $(gcc --version) == *Debian* ]]; then
sudo sed -i "s|Exec=inkscape %F|Exec=$USER_PATH/inkscape/Inkscape.AppImage|g" $LAUNCHER_DESK
fi
sudo rm -rf "$LAUNCHER_PATH" 
sudo mv "$LAUNCHER_DESK" /usr/share/applications/


# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"* --installed 2> /dev/null) == *"$SOFT_PACKAGE"* ]]; then 
    sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
    echo 'Error!'
fi # if installed

fi # if not uninstall
fi # if not root
