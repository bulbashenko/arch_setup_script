#!/bin/sh

echo "Username: "
read NAME

#Install sudo && add user
echo 'y' | pacman -S sudo
groupadd $NAME
useradd -g $NAME -m $NAME
passwd $NAME
echo "$NAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo

#Install pikaur
pacman -S --needed base-devel
git clone https://aur.archlinux.org/pikaur.git
cp -r pikaur/ /home/$NAME/
cd /home/$NAME/pikaur
chown -R $NAME:$NAME /home/$NAME/pikaur/
sudo -u $NAME makepkg -fsri

#Install audio
pikaur -S pulseaudio
cp daemon.conf /home/$NAME/.config/pulse/daemon.conf

#Install budgie
pikaur -S xorg xorg-server budgie-desktop-git gnome-terminal gdm
echo 'y' | pikaur -S arc-gtk-theme papirus-icon-theme
pikaur -S budgie-network-applet
systemctl enable NetworkManager
systemctl enable gdm

#Install apps
pikaur -S discord telegram-desktop firefox

#Some features
cd ~/arch_setup_script
cp -r Wallpapers/ /home/$NAME/Pictures
chown -R $NAME:$NAME /home/$NAME/Pictures/Wallpapers

