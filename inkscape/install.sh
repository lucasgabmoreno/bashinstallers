#!/bin/bash

bash uninstall.sh

sudo add-apt-repository ppa:inkscape.dev/stable-1.1 -y
sudo apt-get update -y
sudo apt install inkscape -y

sudo echo "Inkscape installed!"
