# Blender
<img src="preview.svg" width="200">

## Install flatpak
```
flatpak install flathub org.blender.Blender
```

## Install .tar.xz
```
SOFT_URL="https://download.blender.org/release/Blender4.1/blender-4.1.0-linux-x64.tar.xz"
USER_PATH=$(xdg-user-dir)
wget -t inf "https://github.com/lucasgabmoreno/bashinstallers/raw/main/blender/blender.png"
sudo mv "blender.png" "/usr/share/icons/hicolor/128x128/apps"
wget -t inf "$SOFT_URL"
if [[ ! -f ${SOFT_URL##*/} ]]; then curl -L -O "$SOFT_URL"; fi
mkdir ~/Blender
tar -Jxf ${SOFT_URL##*/} --strip-components=1 -C ~/Blender
rm -rf ${SOFT_URL##*/}
sed -i "s|Exec=blender|Exec=$USER_PATH/Blender/blender|g" ~/Blender/blender.desktop
chmod +x ~/Blender/blender.desktop
cp ~/Blender/blender.desktop "$USER_PATH/.local/share/applications"
sudo cp ~/Blender/blender.desktop /usr/share/applications
sudo cp ~/Blender/blender.svg /usr/share/icons/SOFT_URL="https://download.blender.org/release/Blender4.1/blender-4.1.0-linux-x64.tar.xz"
USER_PATH=$(xdg-user-dir)
wget -t inf "https://github.com/lucasgabmoreno/bashinstallers/raw/main/blender/blender.png"
sudo mv "blender.png" "/usr/share/icons/hicolor/128x128/apps"
wget -t inf "$SOFT_URL"
if [[ ! -f ${SOFT_URL##*/} ]]; then curl -L -O "$SOFT_URL"; fi
mkdir ~/Blender
tar -Jxf ${SOFT_URL##*/} --strip-components=1 -C ~/Blender
rm -rf ${SOFT_URL##*/}
sed -i "s|Exec=blender|Exec=$USER_PATH/Blender/blender|g" ~/Blender/blender.desktop
chmod +x ~/Blender/blender.desktop
cp ~/Blender/blender.desktop "$USER_PATH/.local/share/applications"
sudo cp ~/Blender/blender.desktop /usr/share/applications
sudo cp ~/Blender/blender.svg /usr/share/icons/
```

## Uninstall
```
DESK_PATH=$(xdg-user-dir DESKTOP)
USER_PATH=$(xdg-user-dir)
kill $(pidof blender) 2> /dev/null
sudo apt remove blender* -y 2> /dev/null
sudo apt purge blender* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall org.blender.Blender -y 2> /dev/null
sudo rm -rf "/usr/share/icons/hicolor/128x128/apps/blender.png" 2> /dev/null
sudo rm -rf "/usr/share/icons/blender.svg"  2> /dev/null
sudo rm -rf ~/Blender 2> /dev/null
sudo rm -rf /usr/share/applications/blender.desktop 2> /dev/null
sudo rm -rf $USER_PATH/.local/share/applications/blender.desktop 2> /dev/null
sudo rm -rf ~/.config/blender 2> /dev/null
sudo rm -rf "$DESK_PATH/blender.desktop" 2> /dev/null
```


## Credits
* [Blender](https://www.blender.org/)
* [Ubuntu Hand Book](https://ubuntuhandbook.org/index.php/2021/12/blender-3-0-released-install-tarball/)
* [Papirus](https://github.com/PapirusDevelopmentTeam)
