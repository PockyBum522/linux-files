# This is slower than pkill -HUP
# Try Ctrl + Alt + Esc for what might be a better cinnamon restart

# Slow and needs the "Restart cinnamon" dialog "Yes" pressed after it runs
# pkill -HUP -f "cinnamon --replace"

# Fast, but kills all windows and processes
# sudo systemctl restart lightdm


dbus-send --type=method_call --dest=org.Cinnamon /org/Cinnamon org.Cinnamon.Eval string:"global.real_restart()"

# See also: https://askubuntu.com/questions/143838/how-do-i-restart-cinnamon-from-the-tty


echo ""
echo "Cinnamon is restarting/has been restarted."
echo ""
read -p "Press enter to continue when it is back up..." not_used_var


/media/secondary/repos/linux-files/scripts/repairs/cinnamon/fix-panels.sh

sleep 2

/media/secondary/repos/linux-files/scripts/user_interface/move-windows-to-preset-locations.sh


