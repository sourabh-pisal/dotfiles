################################################################################
#                             Completion Configuration                         #
################################################################################
# Use a cached .zcompdump file if available
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"

# Enable Zsh autocompletion
autoload -Uz compinit

# Only recompile if the .zcompdump is older than 1 day
if [[ -n $zcompdump(#qN.m+1) ]]; then
  compinit -d "$zcompdump"
else
  compinit -C -d "$zcompdump"
fi

# Enable menu selection for completion
zstyle ':completion:*' menu select

################################################################################
#                            Export Variables from .env                        #
################################################################################
# Load environment variables from the .env file if it exists
if [ -f ~/.env ]; then
  export $(grep -v '^#' ~/.env | xargs)
fi

# Load custom scripts
if [ -d "$HOME/.scripts" ]; then
    for script in "$HOME/.scripts"/*.sh; do
        [ -r "$script" ] && source "$script"
    done
fi

# Load Homebrew environment variables
if [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

################################################################################
#                             Environment Variables                            #
################################################################################
# Set the default editor
set -o vi
export VISUAL=nvim
export EDITOR=nvim
export TERM=xterm-256color

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Node.js
export JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=1

# Set rose-pine-dawn theme for FZF
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

################################################################################
#                         Oh My Zsh Configuration                              #
################################################################################
# Set the Zsh theme
ZSH_THEME="robbyrussell"

# Enable Oh My Zsh plugins
plugins=(git sudo tmux)

################################################################################
#                              Path Configuration                              #
################################################################################
# Allow extended globbing and ignore missing files in globs
setopt extended_glob null_glob

# Add custom directories to PATH
path=(
    $path
    $HOME/bin
    $HOME/.local/bin
)

# Remove duplicate entries and ensure only valid directories are in PATH
typeset -U path
path=($^path(N-/))

# Export the updated PATH
export PATH

################################################################################
#                           History Configuration                              #
################################################################################
# File to save command history
HISTFILE=~/.histfile

# Number of commands to remember in memory and save to file
HISTSIZE=1000
SAVEHIST=1000

# History behavior options
setopt HIST_IGNORE_SPACE    # Ignore commands prefixed with a space
setopt HIST_IGNORE_DUPS     # Ignore duplicate entries
setopt SHARE_HISTORY        # Share history across sessions

################################################################################
#                                  Aliases                                     #
################################################################################
# General aliases
alias v="nvim"
alias c="clear"

# Git shortcuts
alias gp="git pull"
alias gs="git status"
alias lg="lazygit"


# Dotfiles management (bare repository)
alias dotfiles="/usr/bin/git --git-dir=$HOME/Workplace/dotfiles/ --work-tree=$HOME"

# ls enhancements
alias ls="ls --color=auto"
alias la="ls -lathr"

################################################################################
#                                  Package Management                          #
################################################################################
update() {
    if command -v pacman &>/dev/null; then
        pacman -Qqe > "$HOME/pkglist-pacman.txt"
        sudo pacman -Syu
    fi

    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt upgrade -y
        apt list --installed 2>/dev/null | awk -F/ '{print $1}' > "$HOME/pkglist-apt.txt"
    fi

    if command -v dnf &>/dev/null; then
        sudo dnf upgrade --refresh
        dnf list installed -q | awk '{print $1}' > "$HOME/pkglist-dnf.txt"
    fi

    if command -v snap &>/dev/null; then
        sudo snap refresh
        snap list | tail -n +2 | awk '{print $1}' > "$HOME/pkglist-snap.txt"
    fi

    if command -v brew &>/dev/null; then
        brew update && brew upgrade
        brew list --formula > "$HOME/pkglist-brew.txt"
        brew list --cask > "$HOME/pkglist-brew-cask.txt"
    fi
}

################################################################################
#                                Networking                                    #
################################################################################
# Connect to Wi-Fi by SSID (with optional password)
connect-wifi() {
  if [[ -n "$1" ]]; then
    local ssid="$1"
    local pass="$2"
    echo "Connecting to Wi-Fi: $ssid ..."
    if [[ -n "$pass" ]]; then
      nmcli device wifi connect "$ssid" password "$pass"
    else
      nmcli device wifi connect "$ssid"
    fi
  else
    echo "Usage: connect-wifi <SSID> [password]"
  fi
}

# Disconnect from current Wi-Fi
disconnect-wifi() {
  local iface
  iface=$(nmcli -t -f DEVICE,TYPE d | awk -F: '$2=="wifi"{print $1; exit}')
  if [[ -n "$iface" ]]; then
    echo "Disconnecting Wi-Fi on interface $iface ..."
    nmcli device disconnect "$iface"
  else
    echo "No Wi-Fi interface found."
  fi
}

# List available Wi-Fi networks
list-wifi() {
  echo "Scanning for available Wi-Fi networks..."
  nmcli device wifi list
}

################################################################################
#                                Audio                                         #
################################################################################
# List audio outputs (sinks) one per line
list-outputs() {
  pactl list short sinks | awk '{print $2}'
}

# List audio inputs (sources) one per line
list-inputs() {
  pactl list short sources | awk '{print $2}'
}

# Set default output (sink)
set-default-output() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-default-output <sink-name>"
    return 1
  fi
  pactl set-default-sink "$1"
}

# Set default input (source)
set-default-input() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-default-input <source-name>"
    return 1
  fi
  pactl set-default-source "$1"
}

# Set volume for default output in percentage
set-output-volume() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-output-volume <volume-percent>"
    return 1
  fi
  pactl set-sink-volume @DEFAULT_SINK@ "$1%"
}

# Set volume for default input in percentage
set-input-volume() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-input-volume <volume-percent>"
    return 1
  fi
  pactl set-source-volume @DEFAULT_SOURCE@ "$1%"
}

################################################################################
#                                Sourcing                                      #
################################################################################
# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Source FZF integration
source <(fzf --zsh)

################################################################################
#                                Start Sway                                    #
################################################################################
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    exec sway
fi
