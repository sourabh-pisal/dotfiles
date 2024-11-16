################################################################################
#                            Export Variables from .env                        #
################################################################################
# Load environment variables from the .env file if it exists
if [ -f ~/.env ]; then
  export $(grep -v '^#' ~/.env | xargs)
fi

################################################################################
#                             Environment Variables                            #
################################################################################
# Set the default editor
set -o vi
export VISUAL=nvim
export EDITOR=nvim

# Wayland debugging variables (for WLR-based compositors)
export WLR_SCENE_DEBUG_DAMAGE=rerender
export WLR_SCENE_DISABLE_VISIBILITY=1

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
alias update="sudo pacman -Syu"

# Dotfiles management (bare repository)
alias dotfiles="/usr/bin/git --git-dir=$HOME/Workplace/dotfiles/ --work-tree=$HOME"

# ls enhancements
alias ls="ls --color=auto"
alias la="ls -lathr"

# Radio streaming
alias lofi="mpv --no-video --quiet $LOFI"
alias wspr="mpv --cache=yes --cache-secs=30 --demuxer-max-bytes=8192k --no-video --quiet --input-ipc-server=wspr '$WSPR'"

################################################################################
#                                Sourcing                                     #
################################################################################
# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Source FZF integration
source <(fzf --zsh)

################################################################################
#                             Completion Configuration                         #
################################################################################
# Enable Zsh autocompletion
autoload -Uz compinit
compinit -u

# Enable menu selection for completion
zstyle ':completion:*' menu select

################################################################################
#                      Start Sway in TTY Mode                                  #
################################################################################
# Automatically start Sway if on TTY1 and not already in a Wayland session
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec sway
fi
