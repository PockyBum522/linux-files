echo "### Adding open withs to right click menu in nemo ###" #########################################################################

# Ensure directory for icons exists
mkdir -p /home/$USER/.local/share/icons/

RES_GITHUB=https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources

# Download all icons
curl $RES_GITHUB/icons/clion.svg > /home/$USER/.local/share/icons/clion.svg
curl $RES_GITHUB/icons/pycharm.svg > /home/$USER/.local/share/icons/pycharm.svg
curl $RES_GITHUB/icons/code.svg > /home/$USER/.local/share/icons/code.svg

# Download the action files to the proper directory for nemo to start using them automatically
curl $RES_GITHUB/nemo_actions/clion-open-folder.nemo_action > /home/$USER/.local/share/nemo/actions/clion-open-folder.nemo_action
curl $RES_GITHUB/nemo_actions/create_link_on_desktop.nemo_action > /home/$USER/.local/share/nemo/actions/create_link_on_desktop.nemo_action
curl $RES_GITHUB/nemo_actions/pycharm-open-folder.nemo_action > /home/$USER/.local/share/nemo/actions/pycharm-open-folder.nemo_action
curl $RES_GITHUB/nemo_actions/vscode-open-folder.nemo_action > /home/$USER/.local/share/nemo/actions/vscode-open-folder.nemo_action

