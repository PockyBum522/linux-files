# Link /home/user/.xbindkeysrc to github dotfile
mkdir -p /media/secondary/repos/linux-files/configuration/dotfiles/

curl https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/configuration/dotfiles/.xbindkeysrc > /media/secondary/repos/linux-files/configuration/dotfiles/.xbindkeysrc

sudo rm /home/david/.xbindkeysrc

ln -s /media/secondary/repos/linux-files/configuration/dotfiles/.xbindkeysrc /home/david/.xbindkeysrc

