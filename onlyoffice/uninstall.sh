#!/bin/bash

sudo apt remove onlyoffice* -y
sudo apt purge onlyoffice* -y
sudo apt autoremove -y

sudo flatpak uninstall org.onlyoffice.desktopeditors* -y

echo "OnlyOffice uninstalled!"

