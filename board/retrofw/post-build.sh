#!/bin/sh
TARGET=$1

mkdir -p \
	"${TARGET}"/home/retrofw \
	"${TARGET}"/boot \
#

rm -rf \
	"${TARGET}"/lost+found \
	"${TARGET}"/etc/init.d/S01syslogd \
	"${TARGET}"/etc/init.d/S02klogd \
	"${TARGET}"/etc/init.d/S20urandom \
	"${TARGET}"/etc/init.d/S80dnsmasq \
	"${TARGET}"/etc/init.d/S50telnet \
	"${TARGET}"/var/lib/opkg \
	"${TARGET}"/run \
	"${TARGET}"/var/lib/opkg \
#

chmod +x \
	"${TARGET}"/etc/init.d/* \
	"${TARGET}"/etc/profile.d/* \
	"${TARGET}"/usr/bin/retrofw \
	"${TARGET}"/usr/bin/*.sh \
#

ln -sf /home/retrofw/.opkg "${TARGET}"/var/lib/opkg
ln -sf /tmp "${TARGET}"/run
ln -sf /etc/issue "${TARGET}"/etc/issue.net
ln -sf /lib/libc.so.0 "${TARGET}"/lib/libpthread.so.0
ln -sf /lib/libc.so.0 "${TARGET}"/lib/libm.so.0
ln -sf /lib/libc.so.0 "${TARGET}"/lib/libdl.so.0

sed -i "s/VERSION_ID.*/VERSION_ID=$(date -I)/" "${TARGET}"/etc/os-release
