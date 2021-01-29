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

#Install budgie
pacman -S budgie-desktop gnome dnsmasq
systemctl enable NetworkManager

#Install nvidia
pacman -S nvidia nvidia-settings nvidia-prime 

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

#Install applets
sudo -u $NAME pikaur -S budgie-network-applet
systemctl enable gdm

#Some features
cd ~/arch_setup_script
cp wallpaper.jpg /home/$NAME
chown -R $NAME:$NAME /home/$NAME/wallpaper.jpg

#Add git
sudo -u $NAME git config --global user.name "$gitUser"
sudo -u $NAME git config --global user.email "$gitEmail"

