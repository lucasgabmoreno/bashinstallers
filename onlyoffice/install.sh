#!/bin/bash

bash uninstall.sh

downinstallrm () {
sudo wget "$1/$2"
sudo dpkg -i "$2"
sudo rm -rf "$2"
}

downinstallrm 'https://download.onlyoffice.com/install/desktop/editors/linux' 'onlyoffice-desktopeditors_amd64.deb'

# FINAL FIXES
sudo apt --fix-broken install -y
