#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#install aur applications
paru -S ttf-ms-fonts chrome-gnome-shell visual-studio-code-bin librewolf-bin popsicle --noconfirm

#kde aur apps
#paru -S --noconfirm

#xfce4 aur apps
#paru -S webcamoid mugshot xfce4-docklike-plugin lightdm-settings visual-studio-code-bin pamac-aur --noconfirm

#gnome aur apps
#paru -S chrome-gnome-shell adwaita-dark --noconfirm
