#!/bin/bash

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
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then rm -rf uninstall.sh; fi

# Final message
APP_PATH="/usr/share/applications/google-chrome.desktop"
if [ ! -e $APP_PATH ]; then 
echo "Google Chrome uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
