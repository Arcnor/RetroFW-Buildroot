#!/bin/sh

mnt=/media

root=$(cat /proc/cmdline)
root="${root##*root=}"
root="${root%% *}"
root="${root%?}"

mdev_umount()
{
	if grep -qs "${mnt}/$1 " /proc/mounts ; then
		umount -fl "${mnt}/$1";
		rmdir "${mnt}/$1";
	fi
}

mdev_mount()
{
	if [ "/dev/$1" == "${root}1" ] || [ "/dev/$1" == "${root}2" ] || [ "/dev/$1" == "${root}3" ] || grep -q "/dev/$1 " /proc/mounts ; then
		# Already mounted
		exit 0
	fi

	mkdir -p "${mnt}/$1" || exit 1

	if ! mount -t auto -o noatime,check=r,shortname=lower,utf8=true "/dev/$1" "${mnt}/$1"; then
		if ! mount -t auto -o noatime "/dev/$1" "${mnt}/$1"; then
			rmdir "${mnt}/$1"
			exit 1
		fi
	fi
}

case "${ACTION}" in
add|"")
	mdev_umount ${MDEV}
	mdev_mount ${MDEV}
	;;
remove)
	mdev_umount ${MDEV}
	;;
esac
