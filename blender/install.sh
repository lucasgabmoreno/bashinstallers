#!/bin/bash

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
BLENDER="blender-3.0.0-linux-x64.tar.xz"
DOWN_PATH="https://download.blender.org/release/Blender3.0/$BLENDER"
if [ -e ~/.local/share/ ]; then 
    BLENDER_PATH=~/blender 
    USER_PATH=$(xdg-user-dir)
    PREFIX_PATH=~/.local
else 
    BLENDER_PATH="/opt/blender"
    USER_PATH='/opt'
    PREFIX_PATH='/usr'
fi
sudo wget -t inf "$DOWN_PATH"
if [ ! -f "$BLENDER" ]; then curl -L -O "$DOWN_PATH"; fi
sudo mkdir "$BLENDER_PATH"
sudo tar -Jxf "$BLENDER" --strip-components=1 -C "$BLENDER_PATH"
sudo rm -rf "$BLENDER"

# Create desktop launcher
APP_PATH=$PREFIX_PATH/share/applications/blender.desktop
sudo sed -i "s|Exec=blender|Exec=$USER_PATH/blender/blender|g" "$BLENDER_PATH/blender.desktop"
chmodown "$BLENDER_PATH/blender.desktop"
sudo cp "$BLENDER_PATH/blender.desktop" $PREFIX_PATH/share/applications/
sudo cp "$BLENDER_PATH/blender.svg" $PREFIX_PATH/share/icons/
chmodown "$APP_PATH"

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'Blender installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi
