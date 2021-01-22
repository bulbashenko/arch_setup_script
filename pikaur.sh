#Try to install pikaur
pacman -S --needed base-devel
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri

#Try to install applets
pikaur -S budgie-calendar-applet budgie-network-applet

reboot