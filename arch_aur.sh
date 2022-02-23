#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#kde aur apps
paru -S ttf-ms-fonts visual-studio-code-bin timeshift-autosnap --noconfirm

#xfce4 aur apps
#paru -S webcamoid mugshot xfce4-docklike-plugin lightdm-settings --noconfirm
