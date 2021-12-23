#!/bin/bash

sudo rm -rf /opt/blender
sudo rm -rf ~/.local/share/applications/blender.desktop
sudo rm -rf ~/.local/share/icons/blender.svg

sudo apt remove blender* -y
sudo apt purge blender* -y
sudo apt autoremove -y

sudo flatpak uninstall org.blender.Blender* -y

echo "Blender uninstalled!"

