#!/bin/bash

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Close
kill $(pidof inkscape) 2> /dev/null

# Uninstall
sudo apt remove inkscape* -y 2> /dev/null
sudo apt purge inkscape* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall org.inkscape.Inkscape* -y 2> /dev/null
sudo rm -rf ~/inkscape* 2> /dev/null

# Remove trash
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/org.inkscape.Inkscape.desktop" 2> /dev/null
sudo rm -rf ~/.config/inkscape* 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
    sudo rm -rf uninstall.sh
fi

# Final message
if [[ $(sudo apt list --installed inkscape*  2> /dev/null) != *"inkscape"* ]]; then 
echo "Inkscape uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
