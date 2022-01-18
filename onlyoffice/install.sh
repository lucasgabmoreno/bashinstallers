#!/bin/bash

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install
wget_dpkg_rm() {
sudo wget -t inf "$1/$2"
sudo dpkg -i "$2"
sudo rm -rf "$2"
}
wget_dpkg_rm 'https://download.onlyoffice.com/install/desktop/editors/linux' 'onlyoffice-desktopeditors_amd64.deb'
sudo apt --fix-broken install -y

# Create desktop launcher
FROM_PATH="/usr/share/applications/onlyoffice-desktopeditors.desktop"
sudo chown $USER:$USER $FROM_PATH 
FROM_PATH_STR=$(paste $FROM_PATH)
if [[ $FROM_PATH_STR != *"StartupWMClass"* ]]; then
sudo sed '2 i StartupWMClass=DesktopEditors' "$FROM_PATH" >> onlyoffice-desktopeditors.desktop
sudo rm -rf $FROM_PATH
sudo mv onlyoffice-desktopeditors.desktop /usr/share/applications/
fi
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo cp $FROM_PATH "$DESK_PATH/"
sudo chmod +x "$DESK_PATH/"onlyoffice-desktopeditors.desktop
sudo chown $USER:$USER "$DESK_PATH/"onlyoffice-desktopeditors.desktop

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [ -e $APP_PATH ]; then 
sudo echo 'OnlyOffice installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi

