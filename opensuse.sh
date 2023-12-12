# chrome
wget https://dl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub
zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
zypper refresh
zypper in google-chrome-stable

# vscode
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
zypper refresh
zypper install code

# apps
zypper install neofetch htop shotwell

# fastgate
tee -a /etc/fstab  << END
# map fastgate usb storage
//192.168.1.254/samba/usb1_1 /home/fabri/Fastgate cifs user=admin,vers=1.0,dir_mode=0777,file_mode=0777,pass=admin
END
