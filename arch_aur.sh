#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#install aur applications
paru -S ttf-ms-fonts --noconfirm

#xfce4 aur applications
#paru -S webcamoid mugshot xfce4-docklike-plugin lightdm-settings visual-studio-code-bin pamac-aur --noconfirm
