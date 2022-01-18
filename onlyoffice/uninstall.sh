#!/bin/bash

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

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then rm -rf uninstall.sh; fi

# Final message
APP_PATH="/usr/share/applications/onlyoffice-desktopeditors.desktop"
if [ ! -e $APP_PATH ]; then 
echo "OnlyOffice uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
