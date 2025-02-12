echo "### Adding open withs to right click menu in nemo ###" #########################################################################

nemo_actions_folder=/home/$USER/.local/share/nemo/actions

# Add "open in vscode" to when you right click on an empty folder in linux
printf "[Nemo Action]\nActive=true\nName=Open in VS Code\nComment=Opens current folder in VS Code\n" > "$nemo_actions_folder/vscode-open-folder.nemo_action"
printf "Exec=code " >> "$nemo_actions_folder/vscode-open-folder.nemo_action"
echo %P >> "$nemo_actions_folder/vscode-open-folder.nemo_action"
printf "Icon-Name=code\nSelection=any\nExtensions=any;\nQuote=double\nDependencies=code;\n" >> "$nemo_actions_folder/vscode-open-folder.nemo_action"

# Add open in PyCharm
printf "[Nemo Action]\nActive=true\nName=Open Folder as PyCharm Project\nComment=Open Folder as PyCharm Project\n" > "$nemo_actions_folder/pycharm-open-folder.nemo_action"
printf "Exec=/home/$USER/.local/share/JetBrains/Toolbox/apps/pycharm-professional/bin/pycharm " >> "$nemo_actions_folder/pycharm-open-folder.nemo_action"
echo \"%P\" >> "$nemo_actions_folder/pycharm-open-folder.nemo_action"
printf "Icon-Name=pycharm\nSelection=any\nExtensions=any\nTerminal=false\n" >> "$nemo_actions_folder/pycharm-open-folder.nemo_action"

# Add open in clion
printf "[Nemo Action]\nActive=true\nName=Open Folder as CLion Project\nComment=Open Folder as clion Project\n" > "$nemo_actions_folder/clion-open-folder.nemo_action"
printf "Exec=/home/$USER/.local/share/JetBrains/Toolbox/apps/clion/bin/clion " >> "$nemo_actions_folder/clion-open-folder.nemo_action"
echo \"%P\" >> "$nemo_actions_folder/clion-open-folder.nemo_action"
printf "Icon-Name=clion\nSelection=any\nExtensions=any\nTerminal=false\n" >> "$nemo_actions_folder/clion-open-folder.nemo_action"

# Ensure directory for icons exists
mkdir -p /home/$USER/.local/share/icons/

# Download all icons
curl https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources/icons/clion.svg > /home/$USER/.local/share/icons/clion.svg
curl https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources/icons/pycharm.svg > /home/$USER/.local/share/icons/pycharm.svg
curl https://raw.githubusercontent.com/PockyBum522/linux-files/refs/heads/master/scripts/initialization/resources/icons/code.svg > /home/$USER/.local/share/icons/code.svg

# get the directory this script is being run from
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

