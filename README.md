# gentoo-setup
gentoo minimal setup scripts

# default settings
settings are set to use belgian keyboard and belgium timezone with english system

# environment
* your new gentoo parititon must be mounted to: `/mnt/gentoo`
* the script `stage3.sh` will (should) download stage3 and portage, extract it on the
  right place and bind `/dev` and `/proc` to the filesystem
* chroot on `/mnt/gentoo`
* run `setup.sh ok` on the chroot

# warning
while i'm writing this readme, the scripts are not up to date with latest gentoo's version
and will not works properly, read the script to know the minimal procedure to help you, new
version will be pushed later
