#!/bin/bash

SOFT_URL=$1
SOFT_PACKAGE=onlyoffice

# Permissions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

# Download and install
## Reemplzar $1/$2 por $1 y $2 por lo que va después de la URL
wget_dpkg_rm () {
sudo wget -t inf "$1/$2"
if [ ! -f "$2" ]; then curl -L -O "$1/$2"; fi
sudo mv "$2" inst.deb
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
kill $(pidof DesktopEditors) 2> /dev/null

# Uninstall
sudo apt remove onlyoffice* -y 2> /dev/null
sudo apt purge onlyoffice* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall org.onlyoffice.desktopeditors* -y 2> /dev/null

# Remove trash
FROM_PATH="/usr/share/applications/onlyoffice-desktopeditors.desktop"
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/"onlyoffice-desktopeditors.desktop 2> /dev/null
sudo rm -rf $FROM_PATH
sudo rm -rf ~/.config/onlyoffice* 2> /dev/null
sudo rm -rf ~/.local/share/onlyoffice* 2> /dev/null
sudo rm -rf ~/.local/share/applications/Desktopeditors* 2> /dev/null


# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"*  2> /dev/null) != *"$SOFT_PACKAGE"* ]]; then
    echo "Software uninstalled!"
else
    echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi

# INSTALLER

if [ "$SOFT_URL" != "uninstall" ]; then

wget_dpkg_rm "$SOFT_URL"

# Final fixes
sudo apt --fix-broken install -y

# Desktop launcher
FROM_PATH="/usr/share/applications/onlyoffice-desktopeditors.desktop"
sudo cp "$FROM_PATH" onlyoffice-desktopeditors.desktop
chmodown onlyoffice-desktopeditors.desktop
FROM_PATH_STR=$(paste onlyoffice-desktopeditors.desktop)
if [[ "$FROM_PATH_STR" != *"StartupWMClass"* ]]; then
    sudo sed -i '2 i\StartupWMClass=DesktopEditors' onlyoffice-desktopeditors.desktop
fi # if not StartuoWMClass
sudo sed -i 's|Keywords=Text;|Keywords=Text;winword;excel;powerpnt;|g' onlyoffice-desktopeditors.desktop
sudo rm -rf "$FROM_PATH"
sudo mv onlyoffice-desktopeditors.desktop /usr/share/applications/

# Remove trash
sudo rm -rf ~/.local/share/applications/Desktopeditors* 2> /dev/null

# Remove this insaller
sudo rm -rf install.sh

# Final message
if [[ $(sudo apt list "$SOFT_PACKAGE"*  2> /dev/null) == *"$SOFT_PACKAGE"* ]]; then 
    sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
    echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi # if installed

fi # if not uninstall
fi # if not root