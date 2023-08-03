#!/data/data/com.termux/files/usr/bin/bash

# Ensure we have permissions
termux-setup-storage

if [ -z "$1" ]
then
        # Empty or missing first parameter

        echo ""
        echo "Must run this script with device name as first parameter."
        echo ""
        echo "Backup will be placed in /storage/emulated/0/Termux/Backups/"
        echo ""
        echo "Directory will be created if necessary, backup will be named DATE_TIME_MEMO.tar.gz"
        echo ""
        echo "Please rerun with device name parameter, For example:"
        echo ""
        echo "./Backup_Home_and_Pacman_Packages.sh SshSetupWorking"
        echo ""

else
        # Got non-empty string for first parameter, so we can make the backup

        builtFilename="$(date +%F_%H-%M-%S)_$1.tar.gz"

        backupFolderPath="/storage/emulated/0/Termux/Backups"

        # Make directory to put backups in, if it doesn't exist
        mkdir -p $backupFolderPath

        backupFullPath="$backupFolderPath/$builtFilename"

        echo ""
        echo "Backing up to:"
        echo $backupFullPath
        echo ""

        # Tar and gz home folder and /data/data/com.termux/files/usr, which is packages
        tar -zcvf $backupFullPath $HOME $PREFIX

fi