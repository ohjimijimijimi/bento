#!/bin/bash -eux

# silent LAMP installation
echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

apt-get install -y lamp-server^
apt-get install -y phpmyadmin
apt-get install -y apache2-utils

# install common tools
apt-get install -y vim
apt-get install -y mc
apt-get install -y htop

# disable passing local env throught ssh
sed -i 's/\(AcceptEnv LANG LC_\*\)/#\1/' /etc/ssh/sshd_config

# install GCC to build VBoxGuestAdditions
# apt-get install -y build-essential

# fix VBoxGuestAdditions path
#ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
#
## install LXDE
#apt-get install lubuntu-desktop
