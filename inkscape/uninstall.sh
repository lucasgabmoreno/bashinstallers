#!/bin/bash

sudo apt remove inkscape* -y
sudo apt purge inkscape* -y
sudo apt autoremove -y

sudo flatpak uninstall org.inkscape.Inkscape* -y

echo "Inkscape uninstalled!"

