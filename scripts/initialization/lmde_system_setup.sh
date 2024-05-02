#! /bin/bash

# TODO: Barrier install and config)
# TODO: Kmonad download and automatic start + config download from github
# TODO: Split grouped windows in taskbar
# TODO: en language packs for LMDE
# TODO: Dropbox
# TODO: Set boot and shutdown screens to actually display messages
# TODO: Wallpaper shuffle
# TODO: Flameshot install and config for printscreen starting region ss
# TODO: Parcellite install and config for Alt + C to show history, history items = 300
# TODO: k4dirstat install
# TODO: Set grub timeout to 1s

set -e
set -o pipefail

echo "### Changing grub timeout to 1s ###" ##############################################################################
sed -i '/GRUB_TIMEOUT=5/c\GRUB_TIMEOUT=1' /etc/default/grub
update-grub

echo "### Updating installed packages ###" ##############################################################################

wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null ## Get the @shiftkey package feed for github desktop
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

apt update
apt-get -y upgrade
apt-get -y dist-upgrade


echo "### Setting theme to dark mode ###" ##############################################################################

sudo -H -u otheruser bash -c gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark"
sudo -H -u otheruser bash -c gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Dark"
sudo -H -u otheruser bash -c gsettings set org.cinnamon.theme name "Mint-Y-Dark"


echo "### Installing common programs ###" ###############################################################################

apt install -y install tmux
apt install -y install vim
apt install -y install git
apt install -y install htop
apt install -y install mint-meta-codecs
apt install -y install feh
apt install -y xdotool
apt install -y github-desktop


echo "### Setting system audio volume to 0 (Muted) ###" ################################################################
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume

echo "### Setting up dirs for where to put appimages ###" ################################################################
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

mkdir -p "$USER_HOME/.local"
APP_INSTALLS_DIR="$USER_HOME/.local/share"

if [ ! -f "$APP_INSTALLS_DIR" ]; then
    mkdir -p "$APP_INSTALLS_DIR"
fi

BEEPER_INSTALLS_DIR="$USER_HOME/.local/share/beeper"

if [ ! -f "$USER_HOME/.local/share/beeper" ]; then
    mkdir -p "$BEEPER_INSTALLS_DIR"
fi

echo "### Disabling LMDE welcome dialog at startup ###" ################################################################
if [ ! -f "$USER_HOME/.config/autostart/mintwelcome.desktop" ]; then
    cat >> "$USER_HOME/.config/autostart/mintwelcome.desktop"<<EOF 
[Desktop Entry]
Encoding=UTF-8
Name=mintwelcome
Comment=Linux Mint Welcome Screen
Icon=mintwelcome
Exec=mintwelcome-launcher
Terminal=false
Type=Application
Categories=
X-GNOME-Autostart-enabled=false

EOF

fi


echo "### Downloading latest beeper appimage ###" #########################################################################

if [ ! -f "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage" ]; then
    curl https://download.beeper.com/linux/appImage/x64 > "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage"
fi

chmod +x "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage"

if [ ! -f "$USER_HOME/Desktop/Beeper" ]; then
    ln -s "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage" "$USER_HOME/Desktop/Beeper"
fi


echo "### Downloading and installing jetbrains toolbox ###" ##############################################################

TMP_DIR="/tmp"
INSTALL_DIR="$USER_HOME/.local/share/jetbrains/toolbox/bin"
SYMLINK_DIR="$USER_HOME/.local/bin"

echo -e "\e[94mFetching the URL of the latest version...\e[39m"
ARCHIVE_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')
ARCHIVE_FILENAME=$(basename "$ARCHIVE_URL")

echo -e "\e[94mDownloading $ARCHIVE_FILENAME...\e[39m"
rm "$TMP_DIR/$ARCHIVE_FILENAME" 2>/dev/null || true
wget -q --show-progress -cO "$TMP_DIR/$ARCHIVE_FILENAME" "$ARCHIVE_URL"

echo -e "\e[94mExtracting to $INSTALL_DIR...\e[39m"
mkdir -p "$INSTALL_DIR"
rm "$INSTALL_DIR/jetbrains-toolbox" 2>/dev/null || true
tar -xzf "$TMP_DIR/$ARCHIVE_FILENAME" -C "$INSTALL_DIR" --strip-components=1
rm "$TMP_DIR/$ARCHIVE_FILENAME"
chmod +x "$INSTALL_DIR/jetbrains-toolbox"

echo -e "\e[94mSymlinking to $SYMLINK_DIR/jetbrains-toolbox...\e[39m"
mkdir -p "$SYMLINK_DIR"
rm "$SYMLINK_DIR/jetbrains-toolbox" 2>/dev/null || true
ln -s "$INSTALL_DIR/jetbrains-toolbox" "$SYMLINK_DIR/jetbrains-toolbox"

if [ -z "$CI" ]; then
	echo -e "\e[94mRunning for the first time to set-up...\e[39m"
	( "$INSTALL_DIR/jetbrains-toolbox" & )
	echo -e "\n\e[32mDone! JetBrains Toolbox should now be running, in your application list, and you can run it in terminal as jetbrains-toolbox (ensure that $SYMLINK_DIR is on your PATH)\e[39m\n"
else
	echo -e "\n\e[32mDone! Running in a CI -- skipped launching the AppImage.\e[39m\n"
fi


echo "### Adding $USER_HOME/.local/bin to PATH ###" ######################################################################
echo -e "\nexport PATH=\"$USER_HOME/.local/bin:$PATH\"" >> "$USER_HOME/.bashrc"


echo "### Installing Yubico Authenticator ###" ###########################################################################

apt-get -y install pcscd
systemctl enable --now pcscd

mkdir -p "$APP_INSTALLS_DIR/yubico-authenticator"

if [ ! -f "$APP_INSTALLS_DIR/yubico-authenticator/Yubico-Authenticator.appimage" ]; then
    curl https://developers.yubico.com/yubioath-flutter/Releases/yubioath-desktop-latest-linux.AppImage > "$APP_INSTALLS_DIR/Yubico-Authenticator/Yubico-Authenticator.appimage"
fi

chmod +x "$APP_INSTALLS_DIR/yubico-authenticator/Yubico-Authenticator.appimage"

if [ ! -f "$USER_HOME/Desktop/Authenticator" ]; then
    ln -s "$APP_INSTALLS_DIR/yubico-authenticator/Yubico-Authenticator.appimage" "$USER_HOME/Desktop/Authenticator"
fi

