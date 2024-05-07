#! /bin/bash

# TODO: https://github.com/AdnanHodzic/displaylink-debian

# TODO: Assign hotkey of printscreen to shutter -s (Will need printsc unassigned from take a screenshot action)
# TODO: Alt + 2 for github-desktop
# TODO: Alt + T for beeper

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


echo "### Adding better mirrors ###" ###############################################################################
cat > "/etc/apt/sources.list.d/official-package-repositories.list"<<EOF 
deb https://mirror.cs.jmu.edu/pub/linuxmint/packages faye main upstream import backport 

deb http://atl.mirrors.clouvider.net/debian bookworm main contrib non-free non-free-firmware
deb http://atl.mirrors.clouvider.net/debian bookworm-updates main contrib non-free non-free-firmware
deb http://security.debian.org/ bookworm-security main contrib non-free non-free-firmware

deb http://atl.mirrors.clouvider.net/debian bookworm-backports main contrib non-free non-free-firmware

EOF


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
run-in-user-session gsettings set org.nemo.preferences start-with-dual-pane true
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
run-in-user-session gsettings set org.nemo.window-state side-pane-view 'tree'


echo "### Setting firefox keyboard shortcut ###" ##############################################################################
run-in-user-session gsettings set org.cinnamon.desktop.keybindings custom-list "['__dummy__']"
run-in-user-session gsettings set org.cinnamon.desktop.keybindings custom-list "['__dummy__', 'custom0']"
run-in-user-session dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/binding "['<Alt>f']"
run-in-user-session dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/command "'firefox'"
run-in-user-session dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/name "'Firefox'"


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


# Make sure dir exists
mkdir -p "/media/secondary"
chown david /media/secondary

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


echo "### Updating installed packages ###" ##############################################################################
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null ## Get the @shiftkey package feed for github desktop
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

apt update
apt-get -y upgrade
apt-get -y dist-upgrade


#echo "### Setting panel settings ###" ##############################################################################
#run-in-user-session 


echo "### Installing common programs ###" ###############################################################################
apt install -y tmux
apt install -y vim
apt install -y git
apt install -y htop
apt install -y mint-meta-codecs
apt install -y feh
apt install -y xdotool
apt install -y github-desktop
apt install -y barrier
apt install -y dropbox
apt install -y gparted
apt install -y k4dirstat
apt install -y tigervnc-viewer
apt install -y copyq
apt install -y shutter
apt install -y evtest
apt install -y filezilla


echo "### Installing common programs, flatpak edition ###" ###############################################################################
flatpak install -y com.github.dail8859.NotepadNext
flatpak install -y org.fkoehler.KTailctl
flatpak install -y com.yubico.yubioath


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

echo "### Adding barrier config ###" ###############################################################################
BARRIER_CONFIG_DIR="$USER_HOME/.config/Debauchee"
if [ ! -d "$BARRIER_CONFIG_DIR" ]
then
    mkdir -p "$BARRIER_CONFIG_DIR"
    curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/configuration/dotfiles/Barrier.conf > "$BARRIER_CONFIG_DIR/Barrier.conf"

    if [ "$HOSTNAME" = DAVID-LAPTOP ]; then
        cat >> "$USER_HOME/.config/autostart/barrier.desktop"<<EOF 
[Desktop Entry]
Type=Application
Name=Barrier
Comment=Keyboard and mouse sharing solution
Exec=barrier
Icon=barrier
Terminal=false
Categories=Utility;RemoteAccess;
Keywords=keyboard;mouse;sharing;network;share;
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
Name[en_US]=Barrier
Comment[en_US]=Keyboard and mouse sharing solution
X-GNOME-Autostart-Delay=15

EOF
    fi
fi

chown david /home/david/.config/Debauchee
chown david /home/david/.config/Debauchee/Barrier.conf


echo "### Adding tmux config ###" ###############################################################################
curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/configuration/dotfiles/.tmux.conf > "$USER_HOME/.tmux.conf"


echo "### Adding vim config ###" ###############################################################################
curl https://raw.githubusercontent.com/PockyBum522/linux-files/master/configuration/dotfiles/.vimrc > "$USER_HOME/.vimrc"


echo "### Disabling LMDE welcome dialog at startup ###" ################################################################
if [ ! -d "$USER_HOME/.config/autostart/mintwelcome.desktop" ]
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


echo "### Setting ktailscale to run at startup ###" ################################################################
if [ ! -d "$USER_HOME/.config/autostart/ktailscale.desktop" ]
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
Hidden=false
Name[en_US]=KTailctl
Comment[en_US]=GUI for tailscale on the KDE Plasma desktop
X-GNOME-Autostart-Delay=10

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

sudo chown david "$USER_HOME/.local/share"


echo "### Adding $USER_HOME/.local/bin to PATH ###" ######################################################################
echo -e "\nexport PATH=\"$USER_HOME/.local/bin:$PATH\"" >> "$USER_HOME/.bashrc"


if [ "$HOSTNAME" = DAVID-LAPTOP ]; then
    echo "### Installing nvidia driver ###"  ###########################################################################
    apt install -y nvidia-driver 

    # Set DPI fractional scaling on
    run-in-user-session gsettings set org.cinnamon.muffin experimental-features "['scale-monitor-framebuffer', 'x11-randr-fractional-scaling']"
fi

if [ "$HOSTNAME" = DAVID-DESKTOP ]; then
    echo "### Installing nvidia driver ###" ###########################################################################
    apt install -y nvidia-driver 
    
    # Set UPS power settings and disable sleep on AC
    run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 120
    run-in-user-session gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 60
fi

echo "### Finished installing/configuring everything! ###"  ###########################################################################
