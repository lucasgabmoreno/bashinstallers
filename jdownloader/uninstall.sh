#!/bin/bash

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

# Uninstall
sudo flatpak uninstall org.jdownloader.JDownloader* -y 2> /dev/null
sudo bash "/opt/jd2/Uninstall JDownloader" 2> /dev/null

# Remove trash
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/"JDownloader* 2> /dev/null
sudo rm -rf /usr/share/applications/JDownloader* 2> /dev/null
sudo rm -rf /usr/share/icons/jdownloader* 2> /dev/null
sudo rm -rf /opt/jd2* 2> /dev/null
sudo rm -rf /tmp/JDownloader** 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
chmodown uninstall.sh
rm -rf uninstall.sh
; fi

# Final message
APP_PATH="/usr/share/applications/JDownloader 2-0.desktop"
if [ ! -e "$APP_PATH" ]; then 
echo "JDownloader uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
