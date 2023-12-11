# chrome
wget https://dl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub
zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
zypper ref
zypper in google-chrome-stable

# vscode
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
zypper refresh
zypper install code
