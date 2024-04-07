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

set -e
set -o pipefail

################################################################
echo "### To change grub settings: ###"
echo "### sudo nano /etc/default/grub ###"
echo "### Then: sudo grub-update ###"

apt update
apt-get -y upgrade
apt-get -y dist-upgrade

################################################################
echo "### Setting theme to dark mode ###"

gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Dark"
gsettings set org.cinnamon.theme name "Mint-Y-Dark"

################################################################
echo "### Installing common programs ###"

apt-get -y install tmux
apt-get -y install vim
apt-get -y install git
apt-get -y install htop
apt-get -y install mint-meta-codecs

################################################################
echo "### Setting up dirs for where to put appimages ###"

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

mkdir -p "$USER_HOME/.local"
APP_INSTALLS_DIR="$USER_HOME/.local/share"

mkdir -p "$APP_INSTALLS_DIR"

BEEPER_INSTALLS_DIR="$APP_INSTALLS_DIR/Beeper"
mkdir -p "$BEEPER_INSTALLS_DIR"

###############################################################
echo "### Downloading latest beeper appimage ###"

if [ ! -f "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage" ]; then
    curl https://download.beeper.com/linux/appImage/x64 > "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage"
fi

chmod +x "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage"

if [ ! -f "$USER_HOME/Desktop/Beeper" ]; then
    ln -s "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage" "$USER_HOME/Desktop/Beeper"
fi

##############################################################
echo "### Downloading and installing jetbrains toolbox ###"

TMP_DIR="/tmp"
INSTALL_DIR="$APP_INSTALLS_DIR/JetBrains/Toolbox/bin"
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

#############################################################
echo "### Adding $USER_HOME/.local/bin to PATH ###"
echo -e "\nexport PATH=\"$USER_HOME/.local/bin:$PATH\"" >> "$USER_HOME/.bashrc"

############################################################
echo "### Installing Yubico Authenticator ###"

apt-get -y install pcscd
systemctl enable --now pcscd

mkdir -p "$APP_INSTALLS_DIR/Yubico-Authenticator"

if [ ! -f "$APP_INSTALLS_DIR/Yubico-Authenticator/Yubico-Authenticator.appimage" ]; then
    curl https://developers.yubico.com/yubioath-flutter/Releases/yubioath-desktop-latest-linux.AppImage > "$APP_INSTALLS_DIR/Yubico-Authenticator/Yubico-Authenticator.appimage"
fi

chmod +x "$APP_INSTALLS_DIR/Yubico-Authenticator/Yubico-Authenticator.appimage"

if [ ! -f "$USER_HOME/Desktop/Authenticator" ]; then
    ln -s "$APP_INSTALLS_DIR/Yubico-Authenticator/Yubico-Authenticator.appimage" "$USER_HOME/Desktop/Authenticator"
fi

