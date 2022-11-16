# PhotoGIMP
<img src="preview.svg" width="200">

## Install
```
VERSION='https://github.com/Diolinux/PhotoGIMP/releases/download/1.1/PhotoGIMP.by.Diolinux.v2020.1.for.Flatpak.zip'
wget -q -O - https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/photogimp/install.sh | bash -s $VERSION
```
If you want to set system theme, once installed remove gtkrc config file:
```
mv ~/.config/GIMP/2.10/gtkrc ~/.config/GIMP/2.10/gtkrc.bak
```
## Uninstall
```
wget -q -O - https://raw.githubusercontent.com/lucasgabmoreno/bashinstallers/main/photogimp/install.sh | bash -s uninstall
```
## Software installed:
* gimp
* Dionlinux's PhotoGIMP patch 

## Thanks:
* [Diolinux](https://github.com/Diolinux/PhotoGIMP)
* [GIMP](http://www.gimp.org.es/)
* [Papirus](https://github.com/PapirusDevelopmentTeam)
