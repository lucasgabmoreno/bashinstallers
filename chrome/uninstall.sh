#!/bin/bash

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Close
kill $(pidof chrome) 2> /dev/null

# Uninstall
sudo apt remove google-chrome* -y 2> /dev/null
sudo apt purge google-chrome* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

# Remove trash
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/google-chrome.desktop" 2> /dev/null
sudo rm -rf ~/.config/google-chrome* 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
    sudo rm -rf uninstall.sh
fi

# Final message
if [[ $(sudo apt list --installed google-chrome*  2> /dev/null) != *"google-chrome"* ]]; then 
echo "Google Chrome uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
