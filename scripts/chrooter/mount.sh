sudo mkdir -p ./root
sudo mkdir -p ./tmp
sudo mkdir -p ./var/log
sudo mkdir -p ./var/run/udev

sudo mount ./neon.iso ./filesystem
sudo mount ./filesystem/casper/filesystem.squashfs ./filesystem

sudo mount --bind ./root ./filesystem/root
sudo mount --bind ./tmp ./filesystem/tmp
sudo mount --bind ./var ./filesystem/var

sudo mount --bind /proc ./filesystem/proc
sudo mount --bind /sys ./filesystem/sys
sudo mount --bind /dev ./filesystem/dev
sudo mount --bind /dev/pts ./filesystem/dev/pts
sudo mount --bind /dev/shm ./filesystem/dev/shm
sudo mount --bind /run ./filesystem/run
sudo mount --bind /run/udev ./filesystem/run/udev
sudo mount --bind /run ./filesystem/var/run
sudo mount --bind /run/udev ./filesystem/var/run/udev
