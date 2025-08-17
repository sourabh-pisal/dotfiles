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
export FZF_DEFAULT_OPTS="
	--color=fg:#797593,bg:#faf4ed,hl:#d7827e
	--color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
	--color=border:#dfdad9,header:#286983,gutter:#faf4ed
	--color=spinner:#ea9d34,info:#56949f
	--color=pointer:#907aa9,marker:#b4637a,prompt:#797593"


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

# Package management
if command -v apt >/dev/null 2>&1; then
    update_cmd="sudo apt update && sudo apt upgrade -y"
elif command -v dnf >/dev/null 2>&1; then
    update_cmd="sudo dnf upgrade --refresh"
elif command -v pacman >/dev/null 2>&1; then
    update_cmd="sudo pacman -Syu"
else
    update_cmd="echo 'No supported package manager found.'"
fi

if command -v snap > /dev/null 2>&1; then
  update_cmd="$update_cmd && sudo snap refresh"
fi

# Add brew if available
if command -v brew >/dev/null 2>&1; then
    update_cmd="$update_cmd && brew update && brew upgrade"
else
    update_cmd="$update_cmd"
fi

# Set the update alias
alias update="$update_cmd"

# Dotfiles management (bare repository)
alias dotfiles="/usr/bin/git --git-dir=$HOME/Workplace/dotfiles/ --work-tree=$HOME"

# ls enhancements
alias ls="ls --color=auto"
alias la="ls -lathr"

################################################################################
#                                Sourcing                                     #
################################################################################
# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Source FZF integration
source <(fzf --zsh)

