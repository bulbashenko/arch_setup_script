#!/bin/sh

echo "Username: "
read NAME

#Install sudo && add user
echo 'y' | pacman -S sudo
groupadd $NAME
useradd -g $NAME -m $NAME
passwd $NAME
echo "$NAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo

#Install budgie
pacman -S budgie-desktop gnome gdm dnsmasq
systemctl enable NetworkManager
rm /etc/gdm/custom.conf
cp custom.conf /etc/gdm/
systemctl enable gdm

#Install applets && themes
pacman -S arc-gtk-theme papirus-icon-theme

#Install font
pacman -S ttf-ubuntu-font-family

#Install audio
pacman -S pulseaudio alsa
cp daemon.conf ~/.config/pulse/

#Install apps
pacman -S firefox telegram-desktop discord
