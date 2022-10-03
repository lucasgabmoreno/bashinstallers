#!/bin/bash

SOFT_URL=$1
SOFT_PACKAGE=/opt/jd2/JDownloader2
SOFT_KILL=java
SOFT_FLATPACK=org.jdownloader.JDownloader
DESK_PATH=$(xdg-user-dir DESKTOP) #/home/usernme/Dekstop/
LAUNCHER_PATH="/usr/share/applications/JDownloader2.desktop"
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
sudo bash "/opt/jd2/Uninstall JDownloader" 2> /dev/null
sudo flatpak uninstall "$SOFT_FLATPACK"* -y 2> /dev/null

# Remove trash
sudo rm -rf "$DESK_PATH/"*"$LAUNCHER_DESK" 2> /dev/null
sudo rm -rf /usr/share/applications/*JDownloader* 2> /dev/null
sudo rm -rf /usr/share/icons/jdownloader* 2> /dev/null
sudo rm -rf /opt/jd2* 2> /dev/null
sudo rm -rf /tmp/JDownloader* 2> /dev/null

# Final message
if [ ! -e "$SOFT_PACKAGE" ]; then 
    echo "Software uninstalled!"
else
    echo 'Error!'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then

# Install dependencies
sudo apt-get install megatools -y

megadl --print-names "$SOFT_URL"
sudo bash JDownloader*sh
sudo rm -rf JDownloader*sh

# Final fixes
sudo apt --fix-broken install -y

# Desktop launcher
sudo cp "/usr/share/applications/"*"$LAUNCHER_DESK" "$LAUNCHER_DESK"
chmodown "$LAUNCHER_DESK"
LAUNCHER_DESK_STR=$(paste "$LAUNCHER_DESK")
if [[ "$LAUNCHER_DESK_STR" != *"StartupWMClass"* ]]; then
    sudo sed -i '2 i\StartupWMClass=JDownloader' "$LAUNCHER_DESK"
fi # if not StartuoWMClass
sudo sed -i 's|Icon=/opt/jd2/.install4j/JDownloader2.png|Icon=jdownloader|g' "$LAUNCHER_DESK"
sudo rm -rf "/usr/share/applications/"*"$LAUNCHER_DESK" 
sudo mv "$LAUNCHER_DESK" /usr/share/applications/
sudo cp "/opt/jd2/.install4j/JDownloader2.png" /usr/share/icons/jdownloader.png

# Remove this insaller
sudo rm -rf install.sh

# Final message
if [ -e "$SOFT_PACKAGE" ]; then 
    sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
    echo 'Error!'
fi # if installed

fi # if not uninstall
fi # if not root