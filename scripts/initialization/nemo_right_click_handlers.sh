echo "### Adding open withs to right click menu in nemo ###" #########################################################################

# Ensure directory for icons exists
mkdir -p /home/$USER/.local/share/icons/

# Download all icons
curl https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources/icons/clion.svg > /home/$USER/.local/share/icons/clion.svg
curl https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources/icons/pycharm.svg > /home/$USER/.local/share/icons/pycharm.svg
curl https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources/icons/code.svg > /home/$USER/.local/share/icons/code.svg

# Download the action files to the proper directory for nemo to start using them automatically
curl https://github.com/PockyBum522/linux-files/blob/master/scripts/initialization/resources/nemo_actions/clion-open-folder.nemo_action > /home/$USER/.local/share/nemo/actions/clion-open-folder.nemo_action
curl https://github.com/PockyBum522/linux-files/blob/master/scripts/initialization/resources/nemo_actions/create_link_on_desktop.nemo_action > /home/$USER/.local/share/nemo/actions/create_link_on_desktop.nemo_action
curl https://github.com/PockyBum522/linux-files/blob/master/scripts/initialization/resources/nemo_actions/pycharm-open-folder.nemo_action > /home/$USER/.local/share/nemo/actions/pycharm-open-folder.nemo_action
curl https://github.com/PockyBum522/linux-files/blob/master/scripts/initialization/resources/nemo_actions/vscode-open-folder.nemo_action > /home/$USER/.local/share/nemo/actions/vscode-open-folder.nemo_action

