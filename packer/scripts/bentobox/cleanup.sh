#!/bin/bash -eux

# Obsolete networking
apt-get -y purge ppp pppconfig pppoeconf

# WTFs
apt-get -y purge popularity-contest installation-report landscape-common \
  wireless-tools wpasupplicant ubuntu-serverguide

# Be extra sure with apt
apt-get -y autoremove --purge
apt-get -y autoclean
apt-get -y clean

# Orphans
apt-get -y install deborphan
while [ -n "`deborphan --guess-all --libdevel`" ]; do
  deborphan --guess-all --libdevel | xargs apt-get -y purge
done
apt-get -y purge deborphan dialog

# Be extra sure with apt... again
apt-get -y autoremove --purge
apt-get -y autoclean
apt-get -y clean

# Locales
# ------------------------------
echo 'LANG="en_US.UTF-8"' > /etc/default/locale
echo 'LANGUAGE="en_US:"' >> /etc/default/locale

rm -rf /usr/share/locale/*
rm -rf /usr/share/locales/*
rm -rf /usr/lib/locale/*

locale-gen

# Temporary files
# ------------------------------
rm -rf /tmp/*

# Remove APT files
find /var/lib/apt -type f | xargs rm -f

# Remove caches
find /var/cache -type f -exec rm -rf {} \;

# Bash history
# ------------------------------
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# Log files
# ------------------------------
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Whiteout root
# ------------------------------
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

# Whiteout /boot
# ------------------------------
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

# Erase free space
# ------------------------------
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Wait (othwerise Packer will cry)
# ------------------------------
sync
