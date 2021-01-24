#!/bin/sh

echo "Username: "
read NAME

#Add git config
echo "github username: "
read gitUser
echo "github email: "
read gitEmail

#Install sudo && add user
echo 'y' | pacman -S sudo
groupadd $NAME
useradd -g $NAME -m $NAME
passwd $NAME
echo "$NAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo
sudo -u $NAME git config --global user.email "$gitEmail"
sudo -u $NAME git config --global user.name "$gitUser"

#Install budgie && drivers
pacman -S budgie-desktop gnome gdm dnsmasq
systemctl enable NetworkManager
rm /etc/gdm/custom.conf
cp custom.conf /etc/gdm/
systemctl enable gdm

#Install nvidia
pacman -S nvidia nvidia-settings bumblebee primus
gpasswd -a $NAME bumblebee
systemctl enable bumblebeed

#Install theme
pacman -S arc-gtk-theme papirus-icon-theme

#Install font
pacman -S ttf-ubuntu-font-family

#Install audio
pacman -S pulseaudio alsa
cp daemon.conf ~/.config/pulse/

#Install apps
pacman -S firefox telegram-desktop discord

#Try to install pikaur
pacman -S --needed base-devel
git clone https://aur.archlinux.org/pikaur.git
cp -r pikaur/ /home/$NAME/
cd /home/$NAME/pikaur
chown -R $NAME:$NAME /home/$NAME/pikaur/
sudo -u $NAME makepkg -fsri

#Install budige applet
sudo -u $NAME pikaur -S budgie-network-applet

