#!/bin/bash -eux

PWD=$(pwd)

################################################################################

echo " ----> Enabling vboxguesttools"
VBOXTOOL_TEMPDIR=__TEMP__vboxtools
mkdir $VBOXTOOL_TEMPDIR
cd $VBOXTOOL_TEMPDIR
wget http://download.virtualbox.org/virtualbox/4.3.12/VBoxGuestAdditions_4.3.12.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_4.3.12.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_4.3.12.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
cd $PWD

echo " ----> Enable colored bash"
sed -i 's/#\(force_color_prompt=yes\)/\1/' .bashrc

echo " ----> Setting umask 002"
sed -i 's/#\(umask \).*/\1002/' .profile

# configure vim
echo " ----> Get Vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo " ----> Get basic vimrc configuration"
git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh


