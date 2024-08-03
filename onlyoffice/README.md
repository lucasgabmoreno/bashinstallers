# OnlyOffice
<img src="preview.svg" width="200">

## Install .deb
```
VERSION='https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb'
wget -q -O - https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/onlyoffice/install.sh | bash -s $VERSION
```

## Install flatpak
```
flatpak install flathub org.onlyoffice.desktopeditors
LAUNCHER_PATH="/var/lib/flatpak/app/org.onlyoffice.desktopeditors/current/active/export/share/applications//org.onlyoffice.desktopeditors.desktop"
LAUNCHER_DESK=${LAUNCHER_PATH##*/}
sudo cp "$LAUNCHER_PATH" "$LAUNCHER_DESK"
sudo chmod +x "$LAUNCHER_DESK"
sudo chown $USER:$USER "$LAUNCHER_DESK"
sed -i '/StartupWMClass=onlyoffice/d' "$LAUNCHER_DESK"
LAUNCHER_DESK_STR=$(paste "$LAUNCHER_DESK")
if [[ "$LAUNCHER_DESK_STR" != *"StartupWMClass"* ]]; then
    sudo sed -i '2 i\StartupWMClass=DesktopEditors' "$LAUNCHER_DESK"
fi
sudo rm -rf "$LAUNCHER_PATH" 
sudo mv "$LAUNCHER_DESK" /var/lib/flatpak/app/org.onlyoffice.desktopeditors/current/active/export/share/applications/
```

## Uninstall
```
DESK_PATH=$(xdg-user-dir DESKTOP)
LAUNCHER_PATH="/usr/share/applications/onlyoffice-desktopeditors.desktop"
LAUNCHER_DESK=${LAUNCHER_PATH##*/}
kill $(pidof "DesktopEditors") 2> /dev/null
sudo apt remove "onlyoffice"* -y 2> /dev/null
sudo apt purge "onlyoffice"* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall "org.onlyoffice.desktopeditors"* -y 2> /dev/null
sudo rm -rf "$DESK_PATH/$LAUNCHER_DESK" 2> /dev/null
sudo rm -rf "$LAUNCHER_PATH"
sudo rm -rf ~/.config/onlyoffice* 2> /dev/null
sudo rm -rf ~/.local/share/onlyoffice* 2> /dev/null
sudo rm -rf ~/.local/share/applications/Desktopeditors* 2> /dev/null
sudo rm -rf /usr/share/icons/hicolor/onlyoffice-desktopeditors.png 2> /dev/null
```

## Software installed
* onlyoffice-dektopeditors
* fonts-crosextra-carlito

## Thanks
* [OnlyOffice](https://www.onlyoffice.com/es/)
* [Papirus](https://github.com/PapirusDevelopmentTeam)
