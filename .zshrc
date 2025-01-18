################################################################################
#                            Export Variables from .env                        #
################################################################################
# Load environment variables from the .env file if it exists
if [ -f ~/.env ]; then
  export $(grep -v '^#' ~/.env | xargs)
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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
alias update="sudo apt update && sudo apt upgrade -y && sudo snap refresh && brew upgrade"

# Dotfiles management (bare repository)
alias dotfiles="/usr/bin/git --git-dir=$HOME/Workplace/dotfiles/ --work-tree=$HOME"

# ls enhancements
alias ls="ls --color=auto"
alias la="ls -lathr"

# Radio streaming
alias lofi="mpv --no-video --quiet '$LOFI'"
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


