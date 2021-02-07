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
mkdir /home/$NAME/.config
mkdir /home/$NAME/.config/pulse
cp daemon.conf /home/$NAME/.config/pulse

#Install budgie
pikaur -S xorg xorg-server budgie-desktop gnome-settings-daemon gnome-control-center gnome-screensaver lightdm lightdm-gtk-greeter
pikaur -S gnome-terminal-transparency
pikaur -S xdg-user-dirs
pikaur -S plata-theme papirus-icon-theme
pikaur -S budgie-network-applet budgie-screenshot-applet
systemctl enable lightdm

#Install nvidia
pikaur -S nvidia nvidia-settings nvidia-prime

#Install apps
pikaur -S discord telegram-desktop firefox skypeforlinux-stable-bin mc nautilus eog vlc

#Some features
cd ~/arch_setup_script
mkdir /home/$NAME/Pictures
cp -r Wallpapers/ /home/$NAME/Pictures
chown -R $NAME:$NAME /home/$NAME/Pictures
chown -R $NAME:$NAME /home/$NAME/Pictures/Wallpapers
cp cooling /bin
chown -R $NAME:$NAME /bin/cooling
