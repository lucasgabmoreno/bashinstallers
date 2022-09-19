#!/bin/bash

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Close
kill $(pidof github-desktop) 2> /dev/null

# Uninstall
sudo apt remove github-desktop* -y 2> /dev/null
sudo apt purge github-desktop* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

# Remove trash
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/github-desktop.desktop" 2> /dev/null
sudo rm -rf ~/.config/GitHub\ Desktop* 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
    sudo rm -rf uninstall.sh
fi

# Final message
if [[ $(sudo apt list --installed github-desktop*  2> /dev/null) != *"github-desktop"* ]]; then 
echo "Github Desktop uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
