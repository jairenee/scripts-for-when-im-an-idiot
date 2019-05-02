#!/bin/bash

for i in {45..40} {40..45} ; do echo -en "\e[38;5;${i}m##\e[0m" ; done ; echo
#echo -e "\e[92m==========================================="
echo -e "\e[92mWelcome to the Idiot Circumvention Program!"
echo ~~~ By Jaime Renee Wissner
echo It appears you\'ve damaged your system\'s drivers. This tool will chroot you into your installed system.
echo -e "This program is intended to be run on a live USB or a separate OS on the same system as your damaged system.\e[0m"
#echo -e "==========================================\e[0m"
for i in {45..40} {40..45} ; do echo -en "\e[38;5;${i}m##\e[0m" ; done ; echo
echo

if [[ "$EUID" -ne 0 ]]
  then echo "This tool needs to run as root."
  exit
fi

[[ $DEBUG == true ]] && set -x

lsblk

echo
echo I\'ve listed the detected storage devices above.
echo

read -p "What partition is your root mount (/)? " ROOTPART
if [[ -z $ROOTPART ]]; then
	echo The root mount MUST be provided.
	exit 1
else
	if [[ ! -e /dev/$ROOTPART ]]; then
		echo Device does not seem to exist. Is it in the list above?
		exit 1
	fi
fi

read -p "What partition is your home directory (/home)? " HOMEPART
if [[ -z $HOMEPART ]]; then
	read -p "Are you sure you don't want to mount a home directory? " -n 1 NOHOME
	if [[ $NOHOME == "y" ]]; then
		HOMEPART="not being used today"
		SKIP_HOME_PART=true
	else
		echo
		echo I\'m not doing this recursively. Rerun the script and think carefully.
		exit 1
	fi
else
	if [[ ! -e /dev/$HOMEPART ]]; then
		echo Device does not seem to exist. Is it in the list above?
		exit 1
	fi
fi

echo
echo CONFIRMING! Your root mount is $ROOTPART, and your home mount is $HOMEPART?
read -p "Confirming root mount: $ROOTPART | home mount: $HOMEPART (y/N)" -n 1 -r CONFIRM

case "$CONFIRM" in
	[yY])
		CONFIRMED=true
		echo Continuing...
		;;
	[nN])
		echo Please rerun with the correct mount points.
		exit 1
		;;
	* )
		echo No input. Please rerun to continue.
		exit 1
		;;
esac

if [[ $CONFIRMED == true ]]; then
	cd /
	mount /dev/$ROOTPART /mnt
	[[ $SKIP_HOME_PART != true ]] && mount /dev/$HOMEPART /mnt/home
	cd /mnt
	mount -t proc proc proc/
	mount -t sysfs sys sys/
	mount -o bind /dev dev/
	chroot .
	exit 0
fi

set +x
