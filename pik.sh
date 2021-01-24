cp -r pikaur/ /home/bulbashenko/
cd /home/bulbashenko/pikaur
chown -R bulbashenko:bulbashenko /home/bulbashenko/pikaur/
sudo -u bulbashenko makepkg -fsri
