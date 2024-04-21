# Github Desktop
<img src="preview.svg" width="200">

## Install
```
VERSION='https://github.com/shiftkey/desktop/releases/latest/'
wget -q -O - https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/github/install.sh | bash -s $VERSION
```

## Uninstall
```
DESK_PATH=$(xdg-user-dir DESKTOP)
kill $(pidof github-desktop) 2> /dev/null
sudo apt remove github-desktop* -y 2> /dev/null
sudo apt purge github-desktop* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo rm -rf "$DESK_PATH/github-desktop.desktop" 2> /dev/null
sudo rm -rf /usr/share/applications/github-desktop.desktop
sudo rm -rf ~/.config/GitHub* 2> /dev/null
sudo rm -rf $(xdg-user-dir DOCUMENTS)/GitHub
```


## Credits
* [Shiftkey](https://github.com/shiftkey/desktop)
* [Papirus](https://github.com/PapirusDevelopmentTeam)
