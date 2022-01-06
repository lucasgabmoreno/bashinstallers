#!/bin/bash

# Remove old versions and trash
bash uninstall.sh noremove

# Install
BLENDER="blender-3.0.0-linux-x64.tar.xz"
BLENDER_PATH=~/blender
sudo wget "https://download.blender.org/release/Blender3.0/$BLENDER"
sudo mkdir "$BLENDER_PATH"
sudo tar -Jxf "$BLENDER" --strip-components=1 -C "$BLENDER_PATH"
sudo rm -rf "$BLENDER"

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
USER_PATH=$(xdg-user-dir)
sudo sed -i "s|Exec=blender|Exec=$USER_PATH/blender/blender|g" "$BLENDER_PATH/blender.desktop"
sudo cp "$BLENDER_PATH/blender.desktop" ~/.local/share/applications/
sudo cp "$BLENDER_PATH/blender.svg" ~/.local/share/icons/
sudo chown $USER:$USER ~/.local/share/applications/blender.desktop
sudo chmod +x ~/.local/share/applications/blender.desktop
cp ~/.local/share/applications/blender.desktop "$DESK_PATH/"
sudo chmod +x "$DESK_PATH/"blender.desktop

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
sudo echo "Blender installed!"
