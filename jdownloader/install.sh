#!/bin/bash

bash uninstall.sh

sudo apt-get install megatools -y
megadl --print-names 'https://mega.nz/#!LJ9FyK7b!t88t6YBo2Wm_ABkSO7GikxujDF5Hddng9bgDb8fwoJQ'
sudo bash JD2Setup_x64.sh
sudo rm -rf JD2Setup_x64.sh

sudo rm -rf "/usr/share/applications/JDownloader 2-0.desktop"
sudo rm -rf "/usr/share/applications/JDownloader 2 Update & Rescue-0.desktop"

sudo sed -i 's|Icon=/opt/jd2/.install4j/JDownloader2.png|Icon=jdownloader|g' "/opt/jd2/JDownloader 2.desktop"
sudo sed -i 's|Icon=/opt/jd2/.install4j/JDownloader2Update.png|Icon=jdownloader|g' "/opt/jd2/JDownloader 2 Update & Rescue.desktop"

sudo cp "/opt/jd2/JDownloader 2.desktop" ~/.local/share/applications/
sudo cp "/opt/jd2/JDownloader 2 Update & Rescue.desktop" ~/.local/share/applications/

sudo chown $USER:$USER ~/.local/share/applications/JDownloader\ 2.desktop
sudo chown $USER:$USER ~/.local/share/applications/JDownloader\ 2\ Update\ \&\ Rescue.desktop

sudo cp "/opt/jd2/.install4j/JDownloader2.png" ~/.local/share/icons/jdownloader.png

