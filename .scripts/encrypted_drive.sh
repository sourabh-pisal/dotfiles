# Mount encrypted drive
mountEncryptedDrive() {
    if [ -z "$1" ]; then
        echo "Usage: mountEncrypted <device_name> (e.g., sdx)"
        return 1
    fi
    sudo cryptsetup luksOpen /dev/$1 encryptedDrive &&
    sudo mkdir -p /media/$USER/encryptedDrive &&
    sudo mount -m /dev/mapper/encryptedDrive /media/$USER/encryptedDrive &&
    echo "Encrypted drive mounted at /media/$USER/encryptedDrive"
}

# Unmount and close encrypted drive
umountEncryptedDrive() {
    sudo umount /media/$USER/encryptedDrive &&
    sudo cryptsetup luksClose encryptedDrive &&
    echo "Encrypted drive unmounted and closed."
}

# Run backup using rsync from ~/backup
backupToEncryptedDrive() {
    if mountpoint -q /media/$USER/encryptedDrive; then
        rsync -avh --progress ~/backup/ /media/$USER/encryptedDrive/backup/
        echo "Backup completed."
    else
        echo "Encrypted drive is not mounted. Please run mountEncrypted first."
        return 1
    fi
}

