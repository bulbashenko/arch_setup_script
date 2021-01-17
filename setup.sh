#!/bin/sh
#Install pikaur
pacman -S --needed base-devel git
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri

#Instal budgie
pacman -S budgie-desktop gnome gdm arc-gtk-theme papirus-icon-theme
useradd -m bulbashenko
passwd bulbashenko
systemctl enable gdm
pikaur -S budgie-calendar-applet budgie-network-applet

#Install apps
pacman -S telegram-desktop discord firefox
