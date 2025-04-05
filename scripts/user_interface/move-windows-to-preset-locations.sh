# To find class names: 
# wmctrl -lx

# To find window position and size:
# wmctrl -lG


# Bottom left monitor, 3x3

#   -e 0,2560,1080,1280,677     # 3,1

#   -e 0,2560,1786,1280,678     # 3,2

#   -e 0,2560,2494,1280,678     # 3,3


windowClass='Toolbox.jetbrains-toolbox' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,7240,2500,100,100

windowClass='Navigator.firefox' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,7680,1080,1920,2090

windowClass='beeper.Beeper' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,4800,0,1920,1040

windowClass='seafile-applet.Seafile' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,2880,20,200,1000

windowClass='xed.Xed' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,2560,2494,1280,678

windowClass='desktop.GitHub' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,2560,1080,1280,677

windowClass='nemo.Nemo' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,2560,1786,1280,678

windowClass='gnome-terminal-server.Gnome-terminal' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,2560,2494,1280,678


# Temporary:
windowClass='filezilla.FileZilla' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,4800,1704,1920,1132

windowClass='jetbrains-rider.jetbrains-rider' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,5760,1080,1919,2120

windowClass='obsidian.obsidian' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,3020,1,1780,1040

windowClass='spotify.Spotify' && wmctrl -ir $(wmctrl -lx | grep $windowClass | cut -d" " -f1) -e 0,6720,1,1929,1010


