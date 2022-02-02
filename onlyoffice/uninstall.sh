#!/bin/bash

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

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

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
    sudo rm -rf uninstall.sh
fi

# Final message
if [[ $(sudo apt list onlyoffice*  2> /dev/null) != *"onlyoffice"* ]]; then
    echo "OnlyOffice uninstalled!"
else
    echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi

fi
