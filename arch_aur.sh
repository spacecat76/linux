#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#install aur applications
paru -S ttf-ms-fonts visual-studio-code-bin librewolf-bin pamac-aur timeshift-bin --noconfirm

#xfce4 aur apps
#paru -S webcamoid mugshot xfce4-docklike-plugin lightdm-settings chrome-gnome-shell popsicle--noconfirm
