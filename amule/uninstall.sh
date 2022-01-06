#!/bin/bash

# Hold dependencies
sudo apt-mark hold libcrypto++6 2> /dev/null

# Uninstall
sudo apt remove amule* -y 2> /dev/null
sudo apt purge amule* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo apt-mark unhold libcrypto++6 2> /dev/null

# Remove trash
sudo rm -rf ~/.aMule 2> /dev/null
sudo rm -rf /usr/share/amule 2> /dev/null
sudo rm -rf /etc/gufw/app_profiles/amule.gufw_app 2> /dev/null
sudo rm -rf /usr/share/app-install/desktop/amule:amule.desktop 2> /dev/null
sudo rm -rf /usr/share/app-install/desktop/amule-utils-gui:amulegui.desktop 2> /dev/null
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/amule.desktop" 2> /dev/null

# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then rm -rf uninstall.sh; fi

# Final message
echo "aMule uninstalled!"

