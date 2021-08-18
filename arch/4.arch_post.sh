#setting permission to home folder
chown -R fabri:fabri /home/fabri/

#set x11 KB language (GDM or SDDM)
localectl set-x11-keymap it

#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#aur
paru -S ttf-ms-fonts timeshift visual-studio-code-bin --noconfirm
