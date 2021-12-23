#!/bin/bash

bash uninstall.sh

BLENDER="blender-3.0.0-linux-x64.tar.xz"
PATH_OPT="/opt/blender"

sudo rm -rf "$PATH_OPT"

sudo wget "https://download.blender.org/release/Blender3.0/$BLENDER"

sudo mkdir "$PATH_OPT"
sudo tar -Jxf "$BLENDER" --strip-components=1 -C "$PATH_OPT"

sudo sed -i 's|Exec=blender|Exec=/opt/blender/blender|g' "$PATH_OPT/blender.desktop"

sudo cp "$PATH_OPT/blender.desktop" ~/.local/share/applications/
sudo cp "$PATH_OPT/blender.svg" ~/.local/share/icons/
sudo chown $USER:$USER ~/.local/share/applications/blender.desktop

sudo rm -rf "$BLENDER"

sudo echo "Blender installed!"
