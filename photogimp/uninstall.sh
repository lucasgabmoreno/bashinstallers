#!/bin/bash

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Close
kill $(pidof gimp) 2> /dev/null

# Uninstall
sudo apt remove gimp* -y 2> /dev/null
sudo apt purge gimp* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

# Remove trash
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/gimp.desktop" 2> /dev/null
sudo rm -rf ~/.config/GIMP* 2> /dev/null
sudo rm -rf "/usr/share/icons/photogimp.png" 2> /dev/null
sudo rm -rf "/usr/share/icons/hicolor/128x128/apps/photogimp.png" 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
    sudo rm -rf uninstall.sh
fi

# Final message
if [[ $(sudo apt list --installed gimp*  2> /dev/null) != *"gimp"* ]]; then 
echo "PhotoGIMP uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
