#!/bin/bash

# Close
kill $(pidof mailspring) 2> /dev/null

# Uninstall
sudo apt remove mailspring* -y 2> /dev/null
sudo apt purge mailspring* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

# Remove trash
DESK_PATH=$(xdg-user-dir DESKTOP)
sudo rm -rf "$DESK_PATH/Mailspring.desktop" 2> /dev/null
sudo rm -rf ~/.config/Mailspring* 2> /dev/null
sudo rm -rf ~/.config/autostart/Mailspring* 2> /dev/null
sudo rm -rf /tmp/Mailspring* 2> /dev/null


# Remove this uninstaller
if ([ "$1" != "noremove" ] && [ ! -f .noremove ]); then rm -rf uninstall.sh; fi

# Final message
if [[ $(sudo apt list mailspring*  2> /dev/null) != *"mailspring"* ]]; then 
echo "Mailspring uninstalled!"
else
echo 'ERROR!!! Please copy the error message and paste them into https://github.com/lucasgabmoreno/bashinstallers/issues.'
fi
