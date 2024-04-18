# APFS FUSE
<img src="preview.svg" width="200">

## Install:
```
sudo apt install fuse libfuse3-dev bzip2 libbz2-dev cmake gcc g++ git libattr1-dev zlib1g-dev -y
sudo apt --fix-broken install -y
git clone https://github.com/sgan81/apfs-fuse.git
cd apfs-fuse
git submodule init
git submodule update
mkdir build
cd build
cmake ..
make
sudo cp apfs-* /usr/bin/
sudo cp apfsutil /usr/bin/
sudo rm -rf "$(xdg-user-dir)/apfs-fuse"
```

## Uninstall:
```
sudo rm -rf /usr/bin/apfs-* 2> /dev/null
sudo rm -rf /usr/bin/apfsutil 2> /dev/null
```


## Credits:
* [sgan81r](https://github.com/sgan81/apfs-fuse)
* [devgregw](https://github.com/sgan81/apfs-fuse/issues/149)
