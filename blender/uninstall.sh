#!/bin/bash

# Uninstall
sudo apt remove blender* -y 2> /dev/null
sudo apt purge blender* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall org.blender.Blender* -y 2> /dev/null

# Remove trash
sudo rm -rf /opt/blender  2> /dev/null
sudo rm -rf ~/blender 2> /dev/null
sudo rm -rf ~/.local/share/applications/blender.desktop  2> /dev/null
sudo rm -rf ~/.local/share/icons/blender.svg  2> /dev/null
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/blender.desktop" 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then rm -rf uninstall.sh; fi

# Final message
echo "Blender uninstalled!"

