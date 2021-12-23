#!/bin/bash

#CLEAN
bash uninstall.sh

#VARS
COMMON="amule-common_2.3.2+git20200530.3a77afb-1_all.deb"
LIBWXBASE="libwxbase3.0-0v5_3.0.5.1+dfsg-2_amd64.deb"
LIBWXGTK="libwxgtk3.0-gtk3-0v5_3.0.5.1+dfsg-2_amd64.deb"
AMULE="amule_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"
DAEMON="amule-daemon_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"
UTILS="amule-utils_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"
GUI="amule-utils-gui_2.3.2+git20200530.3a77afb-1+b1_amd64.deb"

PATH_AMULE="https://deb.sipwise.com/debian/pool/main/a/amule"
PATH_WXWIDGETS="http://archive.ubuntu.com/ubuntu/pool/universe/w/wxwidgets3.0"

# LIBCRYPTO++6
sudo apt-get install libcrypto++6 -y

downinstallrm () {
sudo wget "$1/$2"
sudo dpkg -i "$2"
sudo rm -rf "$2"
}

downinstallrm $PATH_AMULE $COMMON
downinstallrm $PATH_WXWIDGETS $LIBWXBASE
downinstallrm $PATH_WXWIDGETS $LIBWXGTK
downinstallrm $PATH_AMULE $AMULE
downinstallrm $PATH_AMULE $DAEMON
downinstallrm $PATH_AMULE $UTILS
downinstallrm $PATH_AMULE $GUI

# EMC
sudo apt-get install amule-emc -y

# PAPIRUS
sudo apt-get install make librsvg2-bin zip -y
sudo git clone https://github.com/PapirusDevelopmentTeam/papirus-amule-theme.git
cd papirus-amule-theme
sudo make build
sudo make install
cd ..
sudo rm -rf papirus-amule-theme

# FINAL FIXES
sudo apt --fix-broken install -y

sudo echo "eMule installed!"
