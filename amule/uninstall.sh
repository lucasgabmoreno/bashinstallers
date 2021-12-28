#!/bin/bash

sudo apt-mark hold libcrypto++6 2> /dev/null
sudo apt remove amule* -y 2> /dev/null
sudo apt purge amule* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo apt-mark unhold libcrypto++6 2> /dev/null

sudo rm -rf ~/.aMule 2> /dev/null

DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/amule.desktop" 2> /dev/null

echo "aMule uninstalled!"

