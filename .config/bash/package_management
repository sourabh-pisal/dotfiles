# Path to your package list file with hostname
PKG_LIST_PATH="${HOME}/.config/pkg/$(cat /etc/hostname).txt"

# Install a package
install() {
    local pkg="$1"
    if [ -z "$pkg" ]; then
        echo "Usage: install <package_name>"
        return 1
    fi

    if command -v pacman &>/dev/null; then
        sudo pacman -S "$pkg"
        sudo pacman -Qqe > "$PKG_LIST_PATH"
    elif command -v apt &>/dev/null; then
        sudo apt install -y "$pkg"
        sudo apt list --installed 2>/dev/null | awk -F/ '{print $1}' > "$PKG_LIST_PATH"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$pkg"
        sudo dnf list installed | awk 'NR>1 {print $1}' | cut -d'.' -f1 > "$PKG_LIST_PATH"
    else
        echo "No supported package manager found."
        return 1
    fi
}

# Remove a package
remove() {
    local pkg="$1"
    if [ -z "$pkg" ]; then
        echo "Usage: remove <package_name>"
        return 1
    fi

    if command -v pacman &>/dev/null; then
        sudo pacman -Rsu "$pkg"
        sudo pacman -Qqe > "$PKG_LIST_PATH"
    elif command -v apt &>/dev/null; then
        sudo apt remove -y "$pkg"
        sudo apt autoremove -y
        sudo apt list --installed 2>/dev/null | awk -F/ '{print $1}' > "$PKG_LIST_PATH"
    elif command -v dnf &>/dev/null; then
        sudo dnf remove -y "$pkg"
        sudo dnf list installed | awk 'NR>1 {print $1}' | cut -d'.' -f1 > "$PKG_LIST_PATH"
    else
        echo "No supported package manager found."
        return 1
    fi
}

# Update packages
update() {
    if command -v pacman &>/dev/null; then
        sudo pacman -Syu
    fi

    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt upgrade -y
    fi

    if command -v dnf &>/dev/null; then
        sudo dnf upgrade --refresh
    fi

    if command -v snap &>/dev/null; then
        sudo snap refresh
    fi

    if command -v brew &>/dev/null; then
        brew update && brew upgrade
    fi
}

