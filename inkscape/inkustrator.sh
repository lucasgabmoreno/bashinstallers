sudo echo "Start"

# Start count
START_TIME=`date +%s` 

SOFT_URL_LAST=$(curl -Ls -o /dev/null -w %{url_effective} $1)
SOFT_URL_PATH=${1%%/latest*}
VERSION=${SOFT_URL_LAST##*tag/}
SOFT_URL="$SOFT_URL_PATH/download/$VERSION/inkustrator-$VERSION.zip"
SOFT_URL_ZIP=${SOFT_URL##*/}
SOFT_URL_DIR=${SOFT_URL_ZIP%%.zip}

sudo wget -t inf $SOFT_URL

sudo chmod -R +x "$SOFT_URL_ZIP"
sudo chown -R $USER:$USER "$SOFT_URL_ZIP"

sudo mkdir -p inkustrator/inkscape
sudo unzip $SOFT_URL_ZIP -d inkustrator/inkscape
sudo rm -rf $SOFT_URL_ZIP
sudo mkdir -p ~/.config/inkscape/

sudo chmod -R +x inkustrator
sudo chown -R $USER:$USER inkustrator
sudo cp -R "inkustrator/inkscape" ~/.config/
sudo rm -rf inkustrator

sudo echo 'Software installed in '$(date -d @$((`date +%s`-$START_TIME)) -u +%H:%M:%S)
