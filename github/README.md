# Github Desktop
<img src="preview.svg" width="200">

## Install flatpak
```
flatpak install flathub io.github.shiftey.Desktop
```

## Install .deb
```
SOFT='https://github.com/shiftkey/desktop/releases/latest/'
SOFT_URL_LAST=$(curl -Ls -o /dev/null -w %{url_effective} $SOFT)
SOFT_URL_PATH=${SOFT%%/latest*}
VERSION=${SOFT_URL_LAST##*release-}
SOFT_URL="$SOFT_URL_PATH/download/release-$VERSION/GitHubDesktop-linux-amd64-$VERSION.deb"
SOFT_DEB=${SOFT_URL##*/}
sudo rm -rf "$SOFT_DEB"* 2> /dev/null
sudo wget -t inf "$SOFT_URL"
if [ ! -f "$SOFT_DEB" ]; then curl -L -O "$SOFT_URL"; fi
sudo mv "$SOFT_DEB" github.deb
sudo chmod +x github.deb
sudo dpkg -i github.deb
sudo rm -rf github.deb
sudo apt --fix-broken install -y
```

## Uninstall
```
DESK_PATH=$(xdg-user-dir DESKTOP)
kill $(pidof github-desktop) 2> /dev/null
sudo apt remove github-desktop* -y 2> /dev/null
sudo apt purge github-desktop* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null
sudo flatpak uninstall io.github.shiftey.Desktop -y 2> /dev/null
sudo rm -rf "$DESK_PATH/github-desktop.desktop" 2> /dev/null
sudo rm -rf /usr/share/applications/github-desktop.desktop
sudo rm -rf ~/.config/GitHub* 2> /dev/null
sudo rm -rf $(xdg-user-dir DOCUMENTS)/GitHub
```


## Credits
* [Shiftkey](https://github.com/shiftkey/desktop)
* [Papirus](https://github.com/PapirusDevelopmentTeam)
