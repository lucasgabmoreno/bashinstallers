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

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
bash uninstall.sh noremove

# Install dependencies
sudo apt-get install libcrypto++6 -y

# Install
PATH_AMULE="https://deb.sipwise.com/debian/pool/main/a/amule"
PATH_WXWIDGETS="http://archive.ubuntu.com/ubuntu/pool/universe/w/wxwidgets3.0"
COMMON="amule-common_2.3.2+git20200530.3a77afb-1_all.deb"
LIBWXBASE="libwxbase3.0-0v5_3.0.5.1+dfsg-2_amd64.deb"
LIBWXGTK="libwxgtk3.0-gtk3-0v5_3.0.5.1+dfsg-2_amd64.deb"
AMULE="amule_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"
DAEMON="amule-daemon_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"
UTILS="amule-utils_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"
GUI="amule-utils-gui_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"
wget_dpkg_rm "$PATH_AMULE" "$COMMON"
wget_dpkg_rm "$PATH_WXWIDGETS" "$LIBWXBASE"
wget_dpkg_rm "$PATH_WXWIDGETS" "$LIBWXGTK"
wget_dpkg_rm "$PATH_AMULE" "$AMULE"
wget_dpkg_rm "$PATH_AMULE" "$DAEMON"
wget_dpkg_rm "$PATH_AMULE" "$UTILS"
wget_dpkg_rm "$PATH_AMULE" "$GUI"

# Install aMule-EMC
sudo apt-get install amule-emc -y

# Final fixes
sudo apt --fix-broken install -y

# Create desktop launcher
DESK_PATH=$(xdg-user-dir DESKTOP)
APP_PATH="/usr/share/applications/amule.desktop"
chmodown "$APP_PATH"
cp "$APP_PATH" "$DESK_PATH/"
chmodown "$DESK_PATH/amule.desktop"

# Remove this insaller
if [ ! -f .noremove ]; then rm -rf install.sh uninstall.sh; fi

# Final message
if [[ $(sudo apt list amule*  2> /dev/null) == *"amule"* ]]; then 
sudo echo 'aMule installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues'
fi
