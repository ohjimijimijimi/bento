#!/bin/bash -eux

# make sure that dkms is installed before running VBoxGuestAdditions.run script
echo " ==> installing basic developer tools"
apt-get install -y linux-headers-generic build-essential dkms

# silent LAMP installation
echo " ==> installing LAMP..."
echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

apt-get install -y lamp-server^
apt-get install -y php5-xdebug
apt-get install -y phpmyadmin
apt-get install -y apache2-utils

# install common tools
echo " ==> Install common tools"
apt-get install -y vim
apt-get install -y mc
apt-get install -y htop
apt-get install -y git
apt-get install -y curl
apt-get install -y exuberant-ctags

# install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# install drush 
sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc
vagrant@bentobox:~$ source $HOME/.bashrc
composer global require drush/drush:6.*

# disable passing local env throught ssh
echo " ==> disabling passing local env throught ssh..."
sed -i 's/\(AcceptEnv LANG LC_\*\)/#\1/' /etc/ssh/sshd_config


### install LXDE
##echo " ==> installing light desktop LXDE..."
##apt-get install -y lubuntu-desktop
