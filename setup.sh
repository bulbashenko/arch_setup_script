#!/bin/sh

echo "Username: "
read NAME

#Install sudo
echo 'y' | pacman -S sudo
useradd -m $NAME
passwd $NAME
echo "$NAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo

#Install budgie
echo 'y' | pacman -S budgie-desktop gnome gdm
systemctl enable gdm
systemctl enable NetworkManager
rm /etc/gdm/custom.conf
cp custom.conf /etc/gdm/

#Install pikaur
su -s $NAME
echo 'y' | sudo pacman -S --needed base-devel git
cd pikaur
makepkg -fsri < pikaur_setup.txt

#Exit from user to root
exit

#Install applets && themes
echo 'y' | pacman -S arc-gtk-theme papirus-icon-theme
pikaur -S budgie-calendar-applet budgie-network-applet < applet_install.txt

#Install font
echo 'y' | pacman -S ttf-ubuntu-font-family

#Install audio
echo 'y' | pacman -S pulseaudio alsa
cp daemon.conf ~/.config/pulse/

#Install nvidia
echo 'y' | pacman -S nvidia nvidia-settings bumblebee mesa-demos
systemctl enable bumblebeed
gpasswd -a $NAME bumblebee

#Install soft
echo 'y' | pacman -S firefox telegram-desktop discord

#Restart system
reboot
