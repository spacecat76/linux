#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#install aur applications
paru -S ttf-ms-fonts librewolf-bin pamac-aur visual-studio-code-bin timeshift-bin --noconfirm

#paru -S webcamoid mugshot xfce4-docklike-plugin lightdm-settings --noconfirm