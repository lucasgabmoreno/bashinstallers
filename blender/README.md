# Blender
<img src="preview.svg" width="200">

## Install .tar.xz
```
VERSION='https://download.blender.org/release/Blender3.3/blender-3.3.1-linux-x64.tar.xz'
wget -q -O - https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/blender/install.sh | bash -s $VERSION
```

## Install flatpak
```
flatpak install flathub org.blender.Blender
```

## Uninstall
```
DESK_PATH=$(xdg-user-dir DESKTOP)
kill $(pidof blender) 2> /dev/null
sudo apt remove blender* -y 2> /dev/null
sudo apt purge blender* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall org.blender.Blender -y 2> /dev/null
sudo rm -rf "/usr/share/icons/hicolor/128x128/apps/blender.png" 2> /dev/null
sudo rm -rf "/usr/share/icons/blender.svg"  2> /dev/null
sudo rm -rf ~/Blender 2> /dev/null
sudo rm -rf /usr/share/applications/blender.desktop 2> /dev/null
sudo rm -rf ~/.config/blender 2> /dev/null
sudo rm -rf "$DESK_PATH/blender.desktop" 2> /dev/null
```


## Credits:
* [Blender](https://www.blender.org/)
* [Ubuntu Hand Book](https://ubuntuhandbook.org/index.php/2021/12/blender-3-0-released-install-tarball/)
* [Papirus](https://github.com/PapirusDevelopmentTeam)
