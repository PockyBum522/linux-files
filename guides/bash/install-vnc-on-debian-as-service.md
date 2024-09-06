# Run the following to install:

sudo apt-get install x11vnc -y

sudo nano /etc/systemd/system/x11vnc.service


# Insert this into the file:

[Unit]
Description="x11vnc"
Requires=display-manager.service
After=display-manager.service

[Service]
ExecStart=/usr/bin/x11vnc -xkb -forever -shared -noxrecord -noxfixes -noxdamage -display :0 -auth guess -rfbauth /home/david/.vnc/passwd
ExecStop=/usr/bin/killall x11vnc
Restart=on-failure
Restart-sec=2

[Install]
WantedBy=multi-user.target


# then run

x11vnc -storepasswd


# Then, start with:

sudo systemctl daemon-reload
sudo systemctl start x11vnc

# And ensure the service starts on boot:

sudo systemctl enable x11vnc


