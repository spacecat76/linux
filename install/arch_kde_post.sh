#!/bin/bash

#paru
git clone https://aur.archlinux.org/paru.git /home/fabri/Downloads/paru
cd /home/fabri/Downloads/paru
makepkg -sri

#aur
paru -S ttf-ms-fonts timeshift visual-studio-code-bin --noconfirm

#kdewallet
tee -a /home/fabri/.config/kwalletrc  << END
[Wallet]
Enabled=false
END