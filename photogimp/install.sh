#!/bin/bash

sudo echo "Start"

SOFT_URL=$1
SOFT_URL_ZIP=${SOFT_URL##*/}
SOFT_URL_DIR=${SOFT_URL_ZIP%%.zip}

SOFT_PACKAGE=gimp
SOFT_KILL=gimp
SOFT_FLATPACK=org.gimp.GIMP
DESK_PATH=$(xdg-user-dir DESKTOP) #/home/usernme/Dekstop/
LAUNCHER_PATH="/usr/share/applications/gimp.desktop"
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
sudo rm -rf ~/.config/GIMP* 2> /dev/null
sudo find /usr/share/icons/ -type f -name "photogimp.png" -delete

# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"* --installed 2> /dev/null) != *"$SOFT_PACKAGE"* ]]; then
    echo "Software uninstalled!"
else
    echo 'Error!'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then


sudo apt-get install gimp -y
sudo apt --fix-broken install -y

sudo wget -t inf $SOFT_URL
sudo unzip $SOFT_URL_ZIP
sudo rm -rf $SOFT_URL_ZIP
sudo mkdir -p ~/.config/GIMP/2.10

sudo cp -R "$SOFT_URL_DIR/.var/app/org.gimp.GIMP/config/GIMP/2.10/"* ~/.config/GIMP/2.10/
sudo chmod -R +x ~/.config/GIMP/2.10
sudo chown -R $USER:$USER ~/.config/GIMP/2.10

sudo cp -R "$SOFT_URL_DIR/.local/share/applications/org.gimp.GIMP.desktop" "$LAUNCHER_PATH"
sudo chmod -R +x "$LAUNCHER_PATH"
sudo chown -R $USER:$USER "$LAUNCHER_PATH"

sudo cp -R "$SOFT_URL_DIR/.local/share/icons/hicolor/"* "/usr/share/icons/hicolor/"
sudo rm -rf $SOFT_URL_DIR

sudo cp "$LAUNCHER_PATH" "$LAUNCHER_DESK"
chmodown "$LAUNCHER_DESK"
sudo sed -i "s|/usr/bin/flatpak\ run\ --branch=stable\ --arch=x86_64\ --command=gimp-2.10\ --file-forwarding\ org.gimp.GIMP\ @@u\ %U\ @@|Exec=gimp-2.10\ %U|g" "$LAUNCHER_DESK"
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
