# Google Chrome
<img src="preview.svg" width="200">

## Install .deb
```
VERSION='https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
wget -q -O - https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/chrome/install.sh | bash -s $VERSION
```
## Install flatpak
```
flatpak install flathub com.google.Chrome
sudo flatpak override com.google.Chrome --filesystem=$HOME/.local/share/applications
sudo flatpak override com.google.Chrome --filesystem=$HOME/.local/share/icons
```
## Uninstall
```
wget -q -O - https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/chrome/install.sh | bash -s uninstall
```

## Software installed:
* google-chrome-stable

## Thanks:
* [Google](https://www.google.com/intl/es-419/chrome/)
* [Papirus](https://github.com/PapirusDevelopmentTeam)
