# Set the sink to use the radeon card:

    # Note: This doesn't work in fish, figure out how to make it work. For now use the below lines to run in bash (Fish would be: set DRI_PRIME 1 /usr/bin/vmware)

    xrandr --setprovideroffloadsink 1 0
    
    bash -c "DRI_PRIME=1 /usr/bin/vmware"


# To check:

    # set DRI_PRIME 1 glxinfo | grep "OpenGL renderer"
    
