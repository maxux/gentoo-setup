#!/bin/sh

set -e

# Downloading and extracting Stage 3
if [ -d /mnt/gentoo ] && [ ! -d /mnt/gentoo/bin ]; then
	echo " * Downloading stage3..."
	cd /tmp
	# wget ftp://mirror.ovh.net/gentoo-distfiles/releases/amd64/current-stage3/stage3-amd64-2*.tar.bz2
	# wget "http://mirror.ovh.net/gentoo-distfiles/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20140731.tar.bz2"

	echo -n " * Extracting stage3... "
	tar -xpf stage3*tar.bz2 -C /mnt/gentoo
	echo "ok."

else
	echo " * Target contains a stage3"
fi

# Downloading and extracting Portage Tree
if [ ! -d /mnt/gentoo/usr/portage ]; then
	echo " * Downloading portage..."
	wget http://mirror.ovh.net/gentoo-distfiles/snapshots/portage-latest.tar.bz2
	
	echo -n " * Extracting... "
	tar -xpf portage-latest.tar.bz2 -C /mnt/gentoo/usr
	echo "ok."

else
	echo " * Target contains a portage tree"
fi

# Mouting pre-chroot
if [ "`mount | grep dev | grep bind`" == "" ]; then
	echo " * Binding /dev"
	mount -o bind /dev /mnt/gentoo/dev
else
	echo " * /dev seems to be mounted"
fi


if [ "`mount | grep proc | grep gentoo`" == "" ]; then
	echo " * Binding /proc"
	mount -t proc none /mnt/gentoo/proc
else
	echo " * /proc seems to be mounted"
fi

echo " * Copy DNS servers settigns..."
cp /etc/resolv.conf /mnt/gentoo/etc/

echo -e "\n * All done. Please chroot."
