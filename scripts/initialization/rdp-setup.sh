#!/bin/bash

sudo apt-get -y install xrdp xorgxrdp
sudo usermod -aG ssl-cert xrdp
echo env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS cinnamon-session>~/.xsession
sudo sed -i 's/^security_layer=negotiate/security_layer=tls/' /etc/xrdp/xrdp.ini
sudo sed -i 's!^certificate=!certificate=/etc/xrdp/cert.pem!' /etc/xrdp/xrdp.ini
sudo sed -i 's!^key_file=!key_file=/etc/xrdp/key.pem!' /etc/xrdp/xrdp.ini
sudo sed -i '/^test -x /i export CINNAMON_2D=1' /etc/xrdp/startwm.sh

# adding port 3389/tcp to local firewall if needed...
sudo systemctl status ufw.service && sudo ufw allow proto tcp from any to any port 3389
echo "please reboot your system"