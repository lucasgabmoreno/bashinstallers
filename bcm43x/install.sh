#!/bin/bash

sudo echo "Start"

SOFT_URL=$1

if [ $USER == "root" ]; then
echo "Don't run as root user"
else

# Start count
START_TIME=`date +%s` 

# Remove old versions and trash
sudo apt remove bcmwl-* broadcom-* b43-* -y 2> /dev/null
sudo apt purge bcmwl-* broadcom-* b43-* -y 2> /dev/null
sudo apt autoremove -y 2> /dev/null

echo "Software uninstalled!"


if [ "$SOFT_URL" != "uninstall" ]; then

# Install driver
CARD=$(sudo lshw -C network)
SUPPORTED=BCM43
MODELS_SUPPORTED1="BCM4311 BCM4312 BCM4313 BCM4321 BCM43142 BCM43224 BCM43225 BCM43227 BCM43228 BCM43331 BCM4360 BCM4352 "
MODELS_SUPPORTED2="BCM4322 "
CARD_PRE="${CARD/*$SUPPORTED/$SUPPORTED}"
MODEL="${CARD_PRE/\ *}"

if [[ "$CARD" != *"$SUPPORTED"* ]]; then
    echo "Hardware not supported. Installer created for $SUPPORTED""xx."
elif [[ "$MODELS_SUPPORTED1$MODELS_SUPPORTED2" != *"$MODEL"' '* ]]; then
    echo "Model not supported. Installer created for: "$MODELS_SUPPORTED1$MODELS_SUPPORTED2
else
    if [[ "$MODELS_SUPPORTED1" == *"$MODEL"' '* ]]; then
        sudo apt-get install broadcom-sta-dkms
    else
        sudo apt-get install bcmwl-kernel-source
    fi
    # Install firmware
    BT_FW=$(dmesg | grep -i bluetooth)
    EXT=.hcd
    BT_FW_PRE="${BT_FW/$EXT*/$EXT}"
    BT_FW_HCD="${BT_FW_PRE/*brcm\/}"
    sudo wget -t inf https://github.com/winterheart/broadcom-bt-firmware/raw/master/brcm/$BT_FW_HCD
    sudo mv $BT_FW_HCD /lib/firmware/brcm/$BT_FW_HCD
    sudo rm -rf $BT_FW_HCD
    if [[ $(sudo apt list --installed broadcom*  2> /dev/null) == *"broadcom"* ]]; then 
        sudo echo 'Installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
        sudo echo "Please reboot!"    
    elif [[ $(sudo apt list --installed bcmwl*  2> /dev/null) == *"bcmwl"* ]]; then
        sudo echo 'Installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
        sudo echo "Please reboot!"
    else
        echo 'Error!'
    fi
fi

fi # if not uninstall
fi # if not root
