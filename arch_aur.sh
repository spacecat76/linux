#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#install aur applications
paru -S ttf-ms-fonts librewolf-bin xfce4-docklike-plugin webcamoid mugshot pamac-aur visual-studio-code-bin lightdm-settings --noconfirm
