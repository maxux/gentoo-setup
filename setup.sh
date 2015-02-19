#!/bin/sh

set -e

if [ "$1" != "ok" ]; then
	echo " * WARNING: Don't launch this script if you're not chrooted !"
	echo " * WARNING: If you're sur, pass 'ok' as argument"
	exit 1
fi

env-update && source /etc/profile

echo " * Setting up timezone..."
cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime
echo "Europe/Brussels" > /etc/timezone

echo " * Setting up dhcp..."
echo 'config_eth0="dhcp"' > /etc/conf.d/net
ln -s /etc/init.d/net.lo /etc/init.d/net.eth0 2> /dev/null
rc-update add net.eth0

echo -n " * Hostname: "
read hst

echo " * Setting up hostname to $hst..."
echo "127.0.0.1		$hst localhost" > /etc/hosts
echo "hostname=$hst" > /etc/conf.d/hostname
hostname $hst

echo " * Setting up keymap..."
sed -i s/'KEYMAP="us"'/'keymap="be-latin1"'/ig /etc/conf.d/keymaps

echo " * Setting up locales"
sed -i s/'^#en_US.UTF-8 UTF-8'/'en_US.UTF-8 UTF-8'/g /etc/locale.gen
locale-gen
eselect locale set en_US.utf8

echo " * Setting up root password"
passwd

echo " * Creating overlay"
mkdir /usr/local/portage 2> /dev/null

echo " * Disabling predicted network"
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

echo " * Disabling tty clear"
sed -i s/linux/'linux --noclear'/g /etc/inittab

echo " * Okay: Please configure /etc/portage/make.conf && /etc/fstab"
echo " * Okay: Please emerge --sync"
echo " * Okay: Please emerge: ccache distcc syslog-ng vixie-cron dhcpcd kernel"
