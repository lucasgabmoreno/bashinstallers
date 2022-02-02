#!/bin/bash

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}
mkdir_p() {
if [ ! -e $1 ]; then
    sudo mkdir -p $1
fi
}

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
sudo wget -t inf "https://github.com/lucasgabmoreno/bashinstallers/raw/main/blender/blender.png"
sudo mv "blender.png" "/usr/share/icons/hicolor/128x128/apps/"
BLENDER="blender-3.0.0-linux-x64.tar.xz"
DOWN_PATH="https://download.blender.org/release/Blender3.0/$BLENDER"

mkdir_p ~/.local/share/applications/
mkdir_p ~/.local/share/icons/

USER_PATH=$(xdg-user-dir)
sudo wget -t inf "$DOWN_PATH"

if [ ! -f "$BLENDER" ]; then
    sudo curl -L -O "$DOWN_PATH"
fi

sudo mkdir ~/blender 
sudo tar -Jxf "$BLENDER" --strip-components=1 -C ~/blender 
sudo rm -rf "$BLENDER"

# Create desktop launcher
sudo sed -i "s|Exec=blender|Exec=$USER_PATH/blender/blender|g" ~/blender/blender.desktop
chmodown ~/blender/blender.desktop
sudo cp ~/blender/blender.desktop ~/.local/share/applications/
sudo cp ~/blender/blender.svg ~/.local/share/icons/
chmodown ~/.local/share/applications/blender.desktop

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'Blender installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi

fi

