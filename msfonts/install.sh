#!/bin/bash

SOFT_URL=$1

sudo echo "Start"

if [ $USER == "root" ]; then
echo "Don't run as root user"
else

# Start count
START_TIME=`date +%s` 

# UNINSTALLER
# Remove
sudo rm -rf /home/lucasgabmoreno/.fonts/clearTypeFonts 2> /dev/null
sudo rm -rf /home/lucasgabmoreno/.fonts/other-essential-fonts 2> /dev/null
sudo rm -rf /home/lucasgabmoreno/.fonts/segoeUI 2> /dev/null
sudo rm -rf /home/lucasgabmoreno/.fonts/tahoma 2> /dev/null

# Final message
echo "Software uninstalled!"

# INSTALLER
if [ "$SOFT_URL" != "uninstall" ]; then

# Calibri - Cambria - Candara - Consolas - Constantia - Corbel
wget -q -O - https://gist.githubusercontent.com/Blastoise/72e10b8af5ca359772ee64b6dba33c91/raw/2d7ab3caa27faa61beca9fbf7d3aca6ce9a25916/clearType.sh | bash

# Tahoma
wget -q -O - https://gist.githubusercontent.com/Blastoise/b74e06f739610c4a867cf94b27637a56/raw/96926e732a38d3da860624114990121d71c08ea1/tahoma.sh | bash

# Segoe-UI
wget -q -O - https://gist.githubusercontent.com/Blastoise/64ba4acc55047a53b680c1b3072dd985/raw/6bdf69384da4783cc6dafcb51d281cb3ddcb7ca0/segoeUI.sh | bash

# Mtextra - Symbol - Webdings - Wingding - Wingdng2 - Wingdng3
wget -q -O - https://gist.githubusercontent.com/Blastoise/d959d3196fb3937b36969013d96740e0/raw/429d8882b7c34e5dbd7b9cbc9d0079de5bd9e3aa/otherFonts.sh | bash

# Final message
sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)

fi # if not uninstall
fi # if not root
