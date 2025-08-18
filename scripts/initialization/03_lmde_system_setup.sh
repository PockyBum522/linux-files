#! /bin/bash

# Before running this on DAVID-DESKTOP, or anything with a finnicky NVIDIA card, do the following:

# Fresh install, and then don't do anything else before doing the below steps:

#       1. Install Nvidia driver from Nvidia site
#       2. Install arandr
#       3. Configure screens per picture on phone in arandr
#       4. Go into display settings, change some small things, click okay, change that thing back, click okay (this is because arandr will set up screen position right but it won't persist after reboot)

# After those, then you can run this script.


read -n 1 -r -s -p $'HAVE YOU READ THE WARNING AT THE TOP OF THE SCRIPT? IF YOU ARE RUNNING THIS ON A COMPUTER WITH A FINNICKY NVIDIA CARD, LOOK AT THE WARNING AND DO WHAT IT SAYS BEFORE RUNNING THIS\n'

read -n 1 -r -s -p $'AGAIN, I AM ASKING YOU: HAVE YOU READ THE WARNING AT THE TOP OF THE SCRIPT? IF YOU ARE RUNNING THIS ON A COMPUTER WITH A FINNICKY NVIDIA CARD, LOOK AT THE WARNING AND DO WHAT IT SAYS BEFORE RUNNING THIS. YOU CAN JUST CLOSE THIS SCRIPT OR CTRL + C IF YOU ARE NOT READY\n'


# TODO: https://github.com/AdnanHodzic/displaylink-debian

# TODO: Assign hotkey of printscreen to shutter -s (Will need printsc unassigned from take a screenshot action)

# TODO: Integrate running right click nemo icons script as user

# TODO: Check if secondary drive is available, and set up automatic mounting at /media/secondary if it is

# TODO: See if there's anything better for my needs than flameshot


set -e
set -o pipefail

function run-in-user-session() {
    _display_id=":$(find /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"
    _username=$(who | grep "\(${_display_id}\)" | awk '{print $1}')
    _user_id=$(id -u "$_username")
    _environment=("DISPLAY=$_display_id" "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$_user_id/bus")
    sudo -Hu "$_username" env "${_environment[@]}" "$@"
}

echo "### Changing grub timeout to 1s ###" ##############################################################################
sed -i '/GRUB_TIMEOUT=5/c\GRUB_TIMEOUT=1' /etc/default/grub
sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/c\GRUB_CMDLINE_LINUX_DEFAULT="quiet"' /etc/default/grub.d/50_lmde.cfg
update-grub


echo "### Setting up dirs for where to put appimages ###" ################################################################
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

mkdir -p "$USER_HOME/.local"
APP_INSTALLS_DIR="$USER_HOME/.local/share"

mkdir -p "$APP_INSTALLS_DIR"

BEEPER_INSTALLS_DIR="$USER_HOME/.local/share/beeper"
mkdir -p "$BEEPER_INSTALLS_DIR"

KMONAD_INSTALL_DIR="$USER_HOME/.local/share/kmonad"
mkdir -p "$KMONAD_INSTALL_DIR"


echo "### Setting theme to dark mode ###" ##############################################################################
run-in-user-session gsettings set org.cinnamon.desktop.interface cursor-theme 'Bibata-Modern-Classic'
run-in-user-session gsettings set org.x.apps.portal color-scheme 'prefer-dark'
run-in-user-session gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-L-Dark'
run-in-user-session gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-L-Dark'
run-in-user-session gsettings set org.cinnamon.theme name 'Mint-L-Dark'

echo "### Turn off most sounds ###" ##############################################################################
run-in-user-session gsettings set org.cinnamon.sounds notification-enabled false
run-in-user-session gsettings set org.cinnamon.sounds login-enabled false
run-in-user-session gsettings set org.cinnamon.sounds logout-enabled false
run-in-user-session gsettings set org.cinnamon.sounds switch-enabled false
run-in-user-session gsettings set org.cinnamon.sounds tile-enabled false

echo "### Setting xed settings ###" ##############################################################################
run-in-user-session gsettings set org.x.editor.preferences.editor display-line-numbers true
run-in-user-session gsettings set org.x.editor.preferences.editor scheme cobalt
run-in-user-session gsettings set org.x.editor.preferences.editor bracket-matching true
run-in-user-session gsettings set org.x.editor.preferences.editor highlight-current-line true
run-in-user-session gsettings set org.x.editor.preferences.editor auto-indent true
run-in-user-session gsettings set org.x.editor.plugins active-plugins "['sort', 'filebrowser', 'docinfo', 'joinlines', 'spell', 'textsize', 'open-uri-context-menu', 'modelines', 'time']"


echo "### Setting desktop icon settings ###" ##############################################################################

run-in-user-session gsettings set org.x.editor.preferences.editor auto-indent true

#/org/nemo/desktop/desktop-layout  'true::true'
run-in-user-session gsettings set org.nemo.desktop desktop-layout true::true

#/org/nemo/desktop/volumes-visible false
run-in-user-session gsettings set org.nemo.desktop volumes-visible false


echo "### Setting update manager to hide icon unless updates are available ###" ##############################################################################
run-in-user-session gsettings set com.linuxmint.updates hide-systray true


echo "### Ignore timeshift message ###" ##############################################################################
run-in-user-session gsettings set com.linuxmint.report ignored-reports "['timeshift-no-setup']"


echo "### Setting notification settings ###" ##############################################################################
run-in-user-session gsettings set org.cinnamon.desktop.notifications bottom-notifications true
run-in-user-session gsettings set org.cinnamon.desktop.notifications remove-old true
run-in-user-session gsettings set org.cinnamon.desktop.notifications notification-duration 3


echo "### Setting nemo file manager settings ###" ##############################################################################
run-in-user-session gsettings set org.nemo.list-view default-zoom-level 'smaller'
run-in-user-session gsettings set org.nemo.preferences default-folder-viewer 'list-view'
run-in-user-session gsettings set org.nemo.preferences click-policy 'single'
run-in-user-session gsettings set org.nemo.preferences ignore-view-metadata true
run-in-user-session gsettings set org.nemo.preferences click-double-parent-folder true
run-in-user-session gsettings set org.nemo.preferences show-full-path-titles true
run-in-user-session gsettings set org.nemo.preferences tooltips-on-desktop true
run-in-user-session gsettings set org.nemo.preferences tooltips-show-file-type true
run-in-user-session gsettings set org.nemo.preferences tooltips-show-mod-date true
run-in-user-session gsettings set org.nemo.preferences tooltips-show-birth-date true
run-in-user-session gsettings set org.nemo.preferences tooltips-show-access-date true
run-in-user-session gsettings set org.nemo.preferences tooltips-show-path true
run-in-user-session gsettings set org.nemo.preferences tooltips-in-list-view true
run-in-user-session gsettings set org.nemo.preferences tooltips-in-icon-view true
run-in-user-session gsettings set org.nemo.preferences show-new-folder-icon-toolbar true
run-in-user-session gsettings set org.nemo.preferences show-open-in-terminal-toolbar true
run-in-user-session gsettings set org.nemo.preferences show-compact-view-icon-toolbar false
run-in-user-session gsettings set org.nemo.preferences show-show-thumbnails-toolbar true
run-in-user-session gsettings set org.nemo.preferences show-icon-view-icon-toolbar true
run-in-user-session gsettings set org.nemo.preferences show-reload-icon-toolbar true
run-in-user-session gsettings set org.nemo.preferences show-computer-icon-toolbar true
run-in-user-session gsettings set org.nemo.preferences.menu-config selection-menu-make-link true
run-in-user-session gsettings set org.nemo.preferences.menu-config selection-menu-duplicate true
run-in-user-session gsettings set org.nemo.preferences show-location-entry true
run-in-user-session gsettings set org.nemo.list-view default-column-order "['name', 'size', 'type', 'date_modified', 'date_created_with_time', 'date_accessed', 'date_created', 'detailed_type', 'group', 'where', 'mime_type', 'date_modified_with_time', 'octal_permissions', 'owner', 'permissions']"
run-in-user-session gsettings set org.nemo.list-view default-visible-columns "['name', 'size', 'type', 'date_modified', 'date_created', 'owner']"

# /org/nemo/preferences/show-hidden-files  true
run-in-user-session gsettings set org.nemo.preferences show-hidden-files true

# /org/nemo/window-state/sidebar-width  281
run-in-user-session gsettings set org.nemo.window-state sidebar-width 290


echo "### Setting power settings ###" ##############################################################################
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 1800
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-ac-action 'suspend'
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-battery-action 'suspend'
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 1800
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 300
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 600
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-ac-timeout 21800
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-ac-action 'nothing'
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-battery-action 'nothing'
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power button-power 'shutdown'
run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power critical-battery-action 'shutdown'



run-in-user-session gsettings set org.x.apps.favorites list "['computer:///::inode/directory', 'file:///home/david::inode/directory', 'file:///media/secondary::inode/directory', 'file:///media/secondary/Dropbox::inode/directory', 'file:///media/secondary/repos::inode/directory']"


echo "### Downloading kmonad ###" ##############################################################################
if [ ! -d "$KMONAD_INSTALL_DIR" ]
then
    curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/bin/kmonad > "$KMONAD_INSTALL_DIR/kmonad"
    chmod +x "$KMONAD_INSTALL_DIR/kmonad"    
    curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/configuration/kmonad/default_layers.kbd > "$KMONAD_INSTALL_DIR/default_layers.kbd"
    groupadd uinput
    usermod -aG input,uinput david
    echo KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput" > /etc/udev/rules.d/80-kmonad.rules
    modprobe uinput
    ./"$KMONAD_INSTALL_DIR/kmonad" &
fi


apt update
apt-get -y upgrade
apt-get -y dist-upgrade


#echo "### Setting panel settings ###" ##############################################################################
#run-in-user-session 


echo "### Installing common programs ###" ###############################################################################
apt install -y tmux
apt install -y remmina
apt install -y vim
apt install -y git
apt install -y htop
apt install -y mint-meta-codecs
apt install -y feh
apt install -y xdotool
apt install -y barrier
apt install -y gparted
apt install -y k4dirstat
apt install -y tigervnc-viewer
apt install -y copyq
apt install -y evtest
apt install -y filezilla
apt install -y mosquitto-clients
apt install -y haskell-stack                    # for kmonad
apt install -y mgba-qt
apt install -y krita
apt install -y chromium
apt install -y usrmerge
apt install -y spotify-client
apt install -y flameshot
apt install -y xbindkeys
apt install -y unzip
apt install -y input-remapper


echo "### Setting up keyboard shortcuts ###" ##############################################################################
# Make custom shortcuts for firefox, beeper, github desktop


# To kill it if it is running
#pkill xbindkeys

echo "### Killed xbindkeys process if it was running ###"

# USER_HOME="/home/david"
# Make default file
if [ ! -f "$USER_HOME/.xbindkeysrc" ]; then

    echo "No xbindkeysrc file found at $USER_HOME so making default file"
        
    # The xbindkeys format is easy, first line is the command and second line is the shortkey.
    # To discover the shortkey, use: $ xbindkeys -k and press the keys.


cat >> "$USER_HOME/.xbindkeysrc"<<EOF 
# For the benefit of emacs users: -*- shell-script -*-
###########################
# xbindkeys configuration #
###########################
#
# Version: 1.8.7
#
# To specify a key, you can use 'xbindkeys --key' or
# 'xbindkeys --multikey' and put one of the two lines in this file.
#
# The format of a command line is:
#    "command to start"
#       associated key
#
# A list of keys is in /usr/include/X11/keysym.h and in
# /usr/include/X11/keysymdef.h
# The XK_ is not needed.
#
# List of modifier:
#   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
#   Mod3 (CapsLock), Mod4, Mod5 (Scroll).
#

# The release modifier is not a standard X modifier, but you can
# use it if you want to catch release events instead of press events

# By defaults, xbindkeys does not pay attention with the modifiers
# NumLock, CapsLock and ScrollLock.
# Uncomment the lines above if you want to pay attention to them.

#keystate_numlock = enable
#keystate_capslock = enable
#keystate_scrolllock= enable


# TO RESTART AFTER MODIFYING THIS FILE 
# sudo pkill xbindkeys && xbindkeys -f "/home/david/.xbindkeysrc"


# PrintScreen key starts interactive flameshot capture
"/usr/bin/flameshot gui"
    Print
    

"firefox"
    Alt + f


"gnome-terminal"
    Alt + 1


"github-desktop"
    Alt + 2


"/home/david/.local/share/beeper/Beeper-Cloud.appimage"
    Alt + t


"/usr/bin/veracrypt"
    Alt + e


"/usr/bin/vmware"
    Alt + m


"/usr/sbin/dotnet /media/secondary/repos/linux-files/bin/WindowPositionsToggle/WindowPositionsToggle.dll"
    Alt + r
    
      
"/usr/bin/spotify"
    Alt + s


"/usr/bin/xed"
    Alt + d


##################################
# End of xbindkeys configuration #
##################################


EOF


    echo  "Changing owner and group of $USER_HOME/.xbindkeysrc"

    chown david "$USER_HOME/.xbindkeysrc"
    chgrp david "$USER_HOME/.xbindkeysrc"

fi


echo  "Restarting xbindkeysrc process with new config file"

# To start xbindkeys
run-in-user-session xbindkeys -f "$USER_HOME/.xbindkeysrc"


echo "### Adding shiftkey repo then installing github desktop ###" ###############################################################################
# Github desktop package feed add
wget -qO - https://mirror.mwt.me/shiftkey-desktop/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/mwt-desktop.gpg > /dev/null
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mwt-desktop.gpg] https://mirror.mwt.me/shiftkey-desktop/deb/ any main" > /etc/apt/sources.list.d/mwt-desktop.list'

# Now install github desktop
apt update
apt-get -y upgrade
apt-get -y dist-upgrade
apt install github-desktop


echo "### Installing common programs, flatpak edition ###" ###############################################################################
flatpak install -y org.fkoehler.KTailctl
flatpak install -y com.yubico.yubioath
flatpak install -y com.bitwarden.desktop
flatpak install -y com.discordapp.Discord
flatpak install -y md.obsidian.Obsidian


echo "### Setting system audio volume to 0 (Muted) ###" ################################################################
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume
xdotool key XF86AudioLowerVolume


# Language packs
apt install -y wbritish
apt install -y firefox-l10n-en


# This needs to be updated to the config files in seafile

#echo "### Adding barrier config ###" ###############################################################################
#BARRIER_CONFIG_DIR="$USER_HOME/.config/Debauchee"
#if [ ! -d "$BARRIER_CONFIG_DIR" ]
#then
#    mkdir -p "$BARRIER_CONFIG_DIR"
#    curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/configuration/dotfiles/Barrier.conf > "$BARRIER_CONFIG_DIR/Barrier.conf"
#
#    if [ "$HOSTNAME" = DAVID-LAPTOP ]; then
#        cat >> "$USER_HOME/.config/autostart/barrier.desktop"<<EOF 
#[Desktop Entry]
#Type=Application
#Name=Barrier
#Comment=Keyboard and mouse sharing solution
#Exec=barrier
#Icon=barrier
#Terminal=false
#Categories=Utility;RemoteAccess;
#Keywords=keyboard;mouse;sharing;network;share;
#X-GNOME-Autostart-enabled=true
#NoDisplay=false
#Hidden=false
#Name[en_US]=Barrier
#Comment[en_US]=Keyboard and mouse sharing solution
#X-GNOME-Autostart-Delay=15
#
#EOF
#    fi
#fi
#
#chown david /home/david/.config/Debauchee
#chown david /home/david/.config/Debauchee/Barrier.conf


echo "### Adding tmux config ###" ###############################################################################
curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/configuration/dotfiles/.tmux.conf > "$USER_HOME/.tmux.conf"


echo "### Adding vim config ###" ###############################################################################
curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/configuration/dotfiles/.vimrc > "$USER_HOME/.vimrc"


echo "### Disabling LMDE welcome dialog at startup ###" ################################################################
if [ ! -f "$USER_HOME/.config/autostart/mintwelcome.desktop" ]
then
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



curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

apt-get update

apt-get install tailscale -y


echo "### Setting ktailscale to run at startup ###" ################################################################
if [ ! -f "$USER_HOME/.config/autostart/ktailscale.desktop" ]
then
    cat >> "$USER_HOME/.config/autostart/ktailscale.desktop"<<EOF 
[Desktop Entry]
Name=KTailctl
Comment=GUI for tailscale on the KDE Plasma desktop
Version=1.5
Exec=/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=ktailctl org.fkoehler.KTailctl
Icon=org.fkoehler.KTailctl
Type=Application
Terminal=false
Categories=Qt;KDE;System;
X-Flatpak=org.fkoehler.KTailctl
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=true
Name[en_US]=KTailctl
Comment[en_US]=GUI for tailscale on the KDE Plasma desktop
X-GNOME-Autostart-Delay=10

EOF
fi


echo "### Setting copyq to run at startup ###" ################################################################
if [ ! -f "$USER_HOME/.config/autostart/com.github.hluk.copyq.desktop" ]
then
    cat >> "$USER_HOME/.config/autostart/com.github.hluk.copyq.desktop"<<EOF 
[Desktop Entry]
Name=CopyQ
Exec=copyq --start-server show
Icon=copyq
GenericName=Clipboard Manager
X-GNOME-Autostart-Delay=1
Type=Application
Terminal=false
X-KDE-autostart-after=panel
X-KDE-StartupNotify=false
X-KDE-UniqueApplet=true
Categories=Qt;KDE;Utility;
GenericName[en_GB]=Clipboard Tool
Comment=A cut & paste history utility
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
Name[en_US]=CopyQ
Comment[en_US]=A cut & paste history utility

EOF
fi


echo "### Setting flameshot to run at startup ###" ################################################################
if [ ! -f "$USER_HOME/.config/autostart/org.flameshot.Flameshot.desktop" ]
then
    cat >> "$USER_HOME/.config/autostart/org.flameshot.Flameshot.desktop"<<EOF 
[Desktop Entry]
Name=Flameshot
GenericName=Screenshot tool
Comment=Powerful yet simple to use screenshot software.
Keywords=flameshot;screenshot;capture;shutter;
Exec=flameshot
Icon=org.flameshot.Flameshot
Terminal=false
Type=Application
Categories=Graphics;
StartupNotify=false
StartupWMClass=flameshot
Actions=Configure;Capture;Launcher;
X-DBUS-StartupType=Unique
X-DBUS-ServiceName=org.flameshot.Flameshot
X-KDE-DBUS-Restricted-Interfaces=org.kde.kwin.Screenshot,org.kde.KWin.ScreenShot2
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
X-GNOME-Autostart-Delay=5

[Desktop Action Configure]
Name=Configure
Exec=flameshot config

[Desktop Action Capture]
Name=Take screenshot
Exec=flameshot gui --delay 500

[Desktop Action Launcher]
Name=Open launcher
Exec=flameshot launcher

EOF
fi


echo "### Setting jetbrains toolbox to run at startup ###" ################################################################
if [ ! -f "$USER_HOME/.config/autostart/JetBrains Toolbox.desktop" ]
then
    cat >> "$USER_HOME/.config/autostart/JetBrains Toolbox.desktop"<<EOF 
[Desktop Entry]
Type=Application
Exec=jetbrains-toolbox
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
Name[en_US]=JatBrains Toolbox
Comment[en_US]=No description
X-GNOME-Autostart-Delay=2

EOF
fi


echo "### Downloading latest beeper appimage ###" #########################################################################
if [ ! -d "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage" ]
then
    curl https://download.beeper.com/linux/appImage/x64 > "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage"
fi

chmod +x "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage"

if [ ! -f "$USER_HOME/Desktop/Beeper" ]
then
    ln -s "$BEEPER_INSTALLS_DIR/Beeper-Cloud.appimage" "$USER_HOME/Desktop/Beeper"
fi


echo "### Setting up kmonad ###" ##############################################################
mkdir -p /home/david/.local/share
cd /home/david/.local/share

echo "### Disabling LMDE welcome dialog at startup ###" ################################################################
if [ ! -d "$USER_HOME/.local/share/kmonad" ]
then
    git clone https://github.com/kmonad/kmonad.git
    cd kmonad
    stack install

fi


echo "### Downloading and installing jetbrains toolbox ###" ##############################################################

# make folders it will need later
mkdir -p "$USER_HOME/.local/share/JetBrains/Toolbox/apps"
mkdir -p "$USER_HOME/.local/share/JetBrains/Toolbox/scripts"

TMP_DIR="/tmp"
INSTALL_DIR="$USER_HOME/.local/share/JetBrains/Toolbox/InstallerBin"
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


# USER_HOME="/home/david"
chown david "$USER_HOME/.local/share"
chown david -R "$USER_HOME/.local/share/beeper"
chown david -R "$USER_HOME/.local/share/JetBrains"
chown david -R "$USER_HOME/.local/share/kmonad"

chgrp david "$USER_HOME/.local/share"
chgrp david -R "$USER_HOME/.local/share/beeper"
chgrp david -R "$USER_HOME/.local/share/JetBrains"
chgrp david -R "$USER_HOME/.local/share/kmonad"

# Now run the thing
"$INSTALL_DIR/jetbrains-toolbox"

echo "### Adding $USER_HOME/.local/bin to PATH ###" ######################################################################
echo -e "\nexport PATH=\"$USER_HOME/.local/bin:$PATH\"" >> "$USER_HOME/.bashrc"


echo "### Adding power icon to next to cinnamon menu ###" ######################################################################
curl https://cinnamon-spices.linuxmint.com/files/applets/sessionManager@scollins.zip > /tmp/sessionManager@scollins.zip

cd /home/david/.local/share/cinnamon/applets/

unzip /tmp/sessionManager@scollins.zip


echo "### Installing directory-menu for cinnamon panel, NOTE you will have to add manually to panel, FIX THIS IN INIT SCRIPT" ######################################################################
# Download and extract all spices applets
curl https://codeload.github.com/linuxmint/cinnamon-spices-applets/zip/refs/heads/master > /tmp/cinnamon-spices-applets.zip
unzip /tmp/cinnamon-spices-applets.zip -d /tmp
 
# Make configuration dir and put config json file into it
mkdir -p "$USER_HOME/.config/cinnamon/spices/directory-menu@torchipeppo"

# Copy extracted applet to /home/user/.local/share/cinnamon/extensions/
mv -r -f /tmp/cinnamon-spices-applets-master/directory-menu@torchipeppo/files/directory-menu@torchipeppo "$USER_HOME/.local/share/cinnamon/applets/directory-menu@torchipeppo"
 
# Cleanup
rm /tmp/cinnamon-spices-applets.zip
rm -rf /tmp/cinnamon-spices-applets-master
 
 
echo "### Adding gtile extension to cinnamon ###" ######################################################################
curl https://cinnamon-spices.linuxmint.com/files/extensions/gTile@shuairan.zip > /tmp/gTile@shuairan.zip

cd /home/david/.local/share/cinnamon/extensions/

unzip /tmp/gTile@shuairan.zip

run-in-user-session gsettings set org.cinnamon enabled-extensions "['gTile@shuairan']"


echo "### Installing superpaper AppImage ###" ######################################################################
mkdir -p /home/david/.local/share/superpaper/
cd /home/david/.local/share/superpaper/
wget https://github.com/hhannine/superpaper/releases/download/v2.2.1/Superpaper-2.2.1-x86_64.AppImage > ./Superpaper-2.2.1-x86_64.AppImage
rm /home/david/.local/share/superpaper/Superpaper-2.2.1-x86_64.AppImage
mv /home/david/.local/share/superpaper/Superpaper-2.2.1-x86_64.AppImage.1 /home/david/.local/share/superpaper/Superpaper-2.2.1-x86_64.AppImage
chmod +x /home/david/.local/share/superpaper/Superpaper-2.2.1-x86_64.AppImage


echo "### Setting superpaper to run at startup ###" ################################################################
if [ ! -f "$USER_HOME/.config/autostart/Superpaper.desktop" ]
then
    cat >> "$USER_HOME/.config/autostart/Superpaper.desktop"<<EOF 
[Desktop Entry]
Type=Application
Exec=/home/david/.local/share/superpaper/Superpaper-2.2.1-x86_64.AppImage
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
Name[en_US]=Superpaper
Comment[en_US]=No description
X-GNOME-Autostart-Delay=5

EOF
fi


echo "### About to run machine/hostname specific work ###" ######################################################################
if [ "$HOSTNAME" = DAVID-LAPTOP ]; then

    # Set DPI fractional scaling on
    run-in-user-session gsettings set org.cinnamon.muffin experimental-features "['scale-monitor-framebuffer', 'x11-randr-fractional-scaling']"
fi

if [ "$HOSTNAME" = DAVID-DESKTOP ]; then

    # Set sleep settings
    run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-ac-timeout 6000
    run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 1200
    run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 120
    run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 60
    
    
    echo "### Adding panels to other monitors ###" ##############################################################################
    
    run-in-user-session gsettings set org.cinnamon panel-zone-icon-sizes '[{"panelId":1,"left":0,"center":0,"right":24},{"left":0,"center":0,"right":0,"panelId":2},{"left":0,"center":0,"right":0,"panelId":3},{"left":0,"center":0,"right":0,"panelId":4},{"left":0,"center":0,"right":0,"panelId":5},{"left":0,"center":0,"right":0,"panelId":6}]'

    run-in-user-session gsettings set org.cinnamon panel-zone-symbolic-icon-sizes '[{"panelId":1,"left":28,"center":28,"right":16},{"left":28,"center":28,"right":28,"panelId":2},{"left":28,"center":28,"right":28,"panelId":3},{"left":28,"center":28,"right":28,"panelId":4},{"left":28,"center":28,"right":28,"panelId":5},{"left":28,"center":28,"right":28,"panelId":6}]'

    run-in-user-session gsettings set org.cinnamon panel-zone-text-sizes '[{"panelId":1,"left":0,"center":0,"right":0},{"left":0,"center":0,"right":0,"panelId":2},{"left":0,"center":0,"right":0,"panelId":3},{"left":0,"center":0,"right":0,"panelId":4},{"left":0,"center":0,"right":0,"panelId":5},{"left":0,"center":0,"right":0,"panelId":6}]'

    run-in-user-session gsettings set org.cinnamon panels-enabled "['1:0:bottom', '2:5:bottom', '3:4:bottom', '4:1:bottom', '5:3:bottom', '6:2:bottom']"

    run-in-user-session gsettings set org.cinnamon panels-height "['1:40', '2:40', '3:40', '4:40', '5:40', '6:40']"

    run-in-user-session gsettings set org.cinnamon panels-hide-delay "['1:0', '2:0', '3:0', '4:0', '5:0', '6:0']"

    run-in-user-session gsettings set org.cinnamon panels-show-delay "['1:0', '2:0', '3:0', '4:0', '5:0', '6:0']"

    # Set autohide false on all panels

    # run-in-user-session gsettings set org.cinnamon panelss-autohide  ['1:false', '2:false', '3:false', '4:false', '5:intel', '6:false']    
    run-in-user-session gsettings set org.cinnamon panels-autohide "['1:false', '2:false', '3:false', '4:false', '5:false', '6:false']"


    echo "### Configuring all panels ###" ######################################################################

    run-in-user-session gsettings set org.cinnamon enabled-applets   "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:2:separator@cinnamon.org:1', 'panel1:right:19:systray@cinnamon.org:3', 'panel1:right:20:xapp-status@cinnamon.org:4', 'panel1:right:21:notifications@cinnamon.org:5', 'panel1:right:22:printers@cinnamon.org:6', 'panel1:right:23:removable-drives@cinnamon.org:7', 'panel1:right:24:keyboard@cinnamon.org:8', 'panel1:right:25:favorites@cinnamon.org:9', 'panel1:right:26:network@cinnamon.org:10', 'panel1:right:27:sound@cinnamon.org:11', 'panel1:right:28:power@cinnamon.org:12', 'panel1:right:29:calendar@cinnamon.org:13', 'panel1:right:30:cornerbar@cinnamon.org:14', 'panel2:left:0:window-list@cinnamon.org:17', 'panel4:left:0:window-list@cinnamon.org:18', 'panel5:left:0:window-list@cinnamon.org:19', 'panel6:left:0:window-list@cinnamon.org:20', 'panel3:left:0:window-list@cinnamon.org:21', 'panel1:left:1:sessionManager@scollins:16', 'panel5:right:0:calendar@cinnamon.org:23', 'panel3:right:0:calendar@cinnamon.org:24', 'panel4:right:0:calendar@cinnamon.org:25', 'panel2:right:0:calendar@cinnamon.org:26', 'panel6:right:0:calendar@cinnamon.org:27', 'panel1:left:5:window-list@cinnamon.org:29', 'panel1:right:17:inhibit@cinnamon.org:30', 'panel1:right:16:force-quit@cinnamon.org:31', 'panel1:right:15:restart-cinnamon@kolle:32', 'panel1:left:4:separator@cinnamon.org:34', 'panel1:right:18:separator@cinnamon.org:35', 'panel1:right:1:separator@cinnamon.org:46', 'panel1:left:3:directory-menu@torchipeppo:47']"

    echo "### Adding superpaper config files ###" #########################################################################
mkdir -p "$USER_HOME/.config/superpaper"

chown david "$USER_HOME/.config/superpaper"
chgrp david "$USER_HOME/.config/superpaper"

RES_GITHUB=https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources/config-files/superpaper/DAVID-DESKTOP

wget $RES_GITHUB/display_systems.dat > "$USER_HOME/.config/superpaper/display_systems.dat"
wget $RES_GITHUB/general_settings > "$USER_HOME/.config/superpaper/general_settings"

mkdir -p "$USER_HOME/.config/superpaper/profiles"

chown david "$USER_HOME/.config/superpaper/profiles"
chgrp david "$USER_HOME/.config/superpaper/profiles"

wget $RES_GITHUB/profiles/Defaults.profile > "$USER_HOME/.config/superpaper/profiles/Defaults.profile"

    fi


    echo "### Setting xed as default file opener for correct filetypes. Apparently .sln counts as text/plain. That is stupid ###" ################################################################

    cat >> "$USER_HOME/.config/mimeapps.list" << EOF 
[Default Applications]
x-scheme-handler/jetbrains=jetbrains-toolbox.desktop
text/plain=org.x.editor.desktop
text/markdown=org.x.editor.desktop

[Added Associations]
text/plain=org.x.editor.desktop;
text/markdown=org.x.editor.desktop;

EOF

echo "### Finished installing/configuring everything! Launching a few things ###"  ###########################################################################

copyq

flameshot

# Now that we're done, show the QR to log in to tailscale

tailscale login --advertise-exit-node --qr # --hostname=OVERRIDE-HOSTNAME-HERE

tailscale up --advertise-exit-node -ssh # --hostname=OVERRIDE-HOSTNAME-HERE



