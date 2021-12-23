#!/bin/bash

sudo apt-mark hold libcrypto++6
sudo apt remove amule* -y
sudo apt purge amule* -y
sudo apt autoremove -y
sudo apt-mark unhold libcrypto++6

sudo rm -rf ~/.aMule

echo "aMule uninstalled!"

