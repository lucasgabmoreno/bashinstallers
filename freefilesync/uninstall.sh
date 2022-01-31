#!/bin/bash

# Close
kill $(pidof FreeFileSync) 2> /dev/null
kill $(pidof FreeFileSync_x86_64) 2> /dev/null
kill $(pidof RealTimeSync) 2> /dev/null
kill $(pidof RealTimeSync_x86_64) 2> /dev/null

# Uninstall 1/2
sudo flatpak uninstall org.freefilesync.FreeFileSync* -y 2> /dev/null
sudo apt remove freefilesync* -y 2> /dev/null
sudo apt purge freefilesync* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

# Remove trash
sudo rm -rf ~/.config/FreeFileSync* 2> /dev/null
if [ -e ~/FreeFileSync/ ]; then 
    sudo rm -rf ~/.local/share/applications/FreeFileSync.desktop 2> /dev/null
    sudo rm -rf ~/.local/share/applications/RealTimeSync.desktop 2> /dev/null
    sudo rm -rf ~/.local/share/icons/freefilesync.png 2> /dev/null
    sudo rm -rf ~/.local/share/icons/realtimesync.png 2> /dev/null
fi
if [ -e /opt/FreeFileSync ]; then
    sudo rm -rf /usr/share/applications/FreeFileSync.desktop 2> /dev/null
    sudo rm -rf /usr/share/applications/RealTimeSync.desktop 2> /dev/null
    sudo rm -rf /usr/share/icons/freefilesync.png 2> /dev/null
    sudo rm -rf /usr/share/share/icons/realtimesync.png 2> /dev/null
fi

# Uninstall 2/2
if [ -e ~/FreeFileSync/ ]; then
    bash ~/FreeFileSync/uninstall.sh 2> /dev/null
fi
if [ -e /opt/FreeFileSync ]; then
    bash /opt/FreeFileSync/uninstall.sh 2> /dev/null
fi

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
    sudo rm -rf uninstall.sh
fi

# Final message
if [ ! -e ~/.local/share/applications/FreeFileSync.desktop ] && [ ! -e /usr/share/applications/FreeFileSync.desktop ]; then 
echo "FreeFileSync uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
