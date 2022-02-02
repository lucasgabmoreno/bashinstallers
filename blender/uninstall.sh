#!/bin/bash

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Close
kill $(pidof blender) 2> /dev/null

# Uninstall
sudo apt remove blender* -y 2> /dev/null
sudo apt purge blender* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall org.blender.Blender* -y 2> /dev/null

# Remove trash
sudo rm -rf "/usr/share/icons/hicolor/128x128/apps/blender.png" 2> /dev/null
sudo rm -rf "~/blender" 2> /dev/null
sudo rm -rf "~/.local/share/applications/blender.desktop"  2> /dev/null
sudo rm -rf "~/.local/share/icons/blender.svg"  2> /dev/null
sudo rm -rf "~/.config/blender" 2> /dev/null
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/blender.desktop" 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then 
    sudo rm -rf uninstall.sh
fi

# Final message
if [ ! -e ~/.local/share/applications/blender.desktop ]; then 
echo "Blender uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

fi
