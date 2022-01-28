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
if [ -e "~/.local/share/" ]; then BLENDER_PATH=~/blender; else BLENDER_PATH="/opt/blender"; fi
sudo wget -t inf "$DOWN_PATH"
if [ ! -f "$BLENDER" ]; then curl -L -O "$DOWN_PATH"; fi
sudo mkdir "$BLENDER_PATH"
sudo tar -Jxf "$BLENDER" --strip-components=1 -C "$BLENDER_PATH"
sudo rm -rf "$BLENDER"

# Create desktop launcher
if [ -e "~/.local/share/" ]; then 
	USER_PATH=$(xdg-user-dir)
	APP_PATH=~/.local/share/applications/blender.desktop
else
	USER_PATH='/opt'
	APP_PATH="/usr/share/applications/blender.desktop"
fi
sudo sed -i "s|Exec=blender|Exec=$USER_PATH/blender/blender|g" "$BLENDER_PATH/blender.desktop"
chmodown "$BLENDER_PATH/blender.desktop"
if [ -e "~/.local/share/" ]; then 
	sudo cp "$BLENDER_PATH/blender.desktop" ~/.local/share/applications/
	sudo cp "$BLENDER_PATH/blender.svg" ~/.local/share/icons/
else
	sudo cp "$BLENDER_PATH/blender.desktop" /usr/share/applications/
	sudo cp "$BLENDER_PATH/blender.svg" /usr/share/icons/
fi
chmodown "$APP_PATH"

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'Blender installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi
