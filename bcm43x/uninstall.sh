#!/bin/bash

sudo apt remove bcmwl-* broadcom-* b43-* -y 2> /dev/null
sudo apt purge bcmwl-* broadcom-* b43-* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then
    sudo rm -rf uninstall.sh
fi

echo "Broadcom BCM43x uninstalled!"
