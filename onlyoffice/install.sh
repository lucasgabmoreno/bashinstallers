#!/bin/bash

# Functions
chmodown() {
sudo chmod +x "$1"
sudo chown $USER:$USER "$1"
}
wget_dpkg_rm () {
sudo wget -t inf "$1/$2"
if [ ! -f "$2" ]; then curl -L -O "$1/$2"; fi
sudo mv "$2" inst.deb
chmodown inst.deb
sudo dpkg -i inst.deb
sudo rm -rf inst.deb
}

if [ $USER == "root" ]; then
echo "Don't run this bash file as root user"
else

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
wget_dpkg_rm 'https://download.onlyoffice.com/install/desktop/editors/linux' 'onlyoffice-desktopeditors_amd64.deb'

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
FROM_PATH="/usr/share/applications/onlyoffice-desktopeditors.desktop"
chmodown "$FROM_PATH" 
FROM_PATH_STR=$(paste $FROM_PATH)
sudo cp "$FROM_PATH" onlyoffice-desktopeditors.desktop
chmodown onlyoffice-desktopeditors.desktop
if [[ "$FROM_PATH_STR" != *"StartupWMClass"* ]]; then
    sudo sed -i '2 i\StartupWMClass=DesktopEditors' onlyoffice-desktopeditors.desktop
fi
sudo sed -i 's|Keywords=Text;|Keywords=Text;winword;excel;powerpnt;|g' onlyoffice-desktopeditors.desktop
sudo rm -rf "$FROM_PATH"
sudo mv onlyoffice-desktopeditors.desktop /usr/share/applications/

# Remove trash
sudo rm -rf ~/.local/share/applications/Desktopeditors* 2> /dev/null

# Remove this insaller
if [ ! -f .noremove ]; then 
    sudo rm -rf install.sh uninstall.sh
fi

# Final message
if [[ $(sudo apt list onlyoffice*  2> /dev/null) == *"onlyoffice"* ]]; then 
    sudo echo 'OnlyOffice installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
    echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi

fi
