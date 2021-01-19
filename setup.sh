#!/bin/sh

echo "Username: "
read NAME

#Install sudo && add user
echo 'y' | pacman -S sudo
useradd -m $NAME
passwd $NAME
echo "$NAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo

#Install budgie
pacman -S budgie-desktop gnome gdm
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

#Install nvidia
pacman -S nvidia nvidia-settings bumblebee mesa-demos
systemctl enable bumblebeed
gpasswd -a $NAME bumblebee

#Install soft
pacman -S firefox telegram-desktop discord

#Try to install pikaur
pacman -S --needed base-devel
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri

#Try to install applets
pikaur -S budgie-calendar-applet budgie-network-applet

#Restart system
reboot
