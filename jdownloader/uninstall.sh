#!/bin/bash

sudo flatpak uninstall org.jdownloader.JDownloader* -y

sudo rm -rf /opt/jd2/
sudo rm -rf ~/.local/share/applications/JDownloader\ 2.desktop
sudo rm -rf ~/.local/share/applications/JDownloader\ 2\ Update\ \&\ Rescue.desktop
sudo rm -rf ~/.local/share/icons/jdownloader.png

echo "JDownloader uninstalled!"

