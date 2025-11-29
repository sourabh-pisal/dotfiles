configure-owncloud() {
    username=$(whoami)
    local url="$1"
    local mountpoint="$2"
    local fstab="/etc/fstab"
    local secrets="/etc/davfs2/secrets"
    local begin="# BEGIN-OWNCLOUD-MOUNT"
    local end="# END-OWNCLOUD-MOUNT"

    if [[ -z "$url" || -z "$mountpoint" ]]; then
        echo "Usage: configure-owncloud <webdav_url> <mountpoint>"
        return 1
    fi

    # Ask for credentials
    echo -n "Enter WebDAV username: "
    read username

    echo -n "Enter WebDAV password: "
    read -s password
    echo

    # Ensure mountpoint exists
    if [[ ! -d "$mountpoint" ]]; then
        echo "Creating $mountpoint"
        sudo mkdir -p "$mountpoint"
    fi

    # Build new fstab block
    echo "Updating /etc/fstab"

    # Remove previous entry
    if grep -q "$begin" "$fstab"; then
        sudo sed -i "/$begin/,/$end/d" "$fstab"
        echo "Removing existing fstab entry."
    fi

    local entry="$begin\n$url  $mountpoint davfs noauto,x-systemd.automount,_netdev,user,uid=$username,rw 0 0\n$end"
    echo -e "$entry" | sudo tee -a "$fstab" >/dev/null
    echo "Added new fstab entry."

    echo "Updating WebDAV credentials in $secrets"

    # Ensure secrets file exists with correct perms
    if [[ ! -f "$secrets" ]]; then
        sudo touch "$secrets"
        sudo chmod 600 "$secrets"
    fi

    # Remove existing entry for this URL or mountpoint
    sudo sed -i "\|$url|d" "$secrets"
    sudo sed -i "\|$mountpoint|d" "$secrets"

    # Append new secrets entry (URL or mountpoint both work)
    echo "$url $username $password" | sudo tee -a "$secrets" >/dev/null

    # Ensure correct permissions again
    sudo chmod 600 "$secrets"
    echo "Credentials stored."

    echo "Done. You can mount with: mount $mountpoint"
}

