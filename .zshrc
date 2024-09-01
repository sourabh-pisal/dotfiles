# -------------------- Environment variales --------------------

# Set vim as an editor
set -o vi

export VISUAL=nvim
export EDITOR=nvim

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git sudo tmux)

# -------------------- Path configuration --------------------
setopt extended_glob null_glob

path=(
    $path                           
    $HOME/bin
    $HOME/.local/bin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# -------------------- History --------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# -------------------- Aliases --------------------
alias v="nvim"
alias c="clear"

# Git
alias gp="git pull"
alias gs="git status"
alias lg="lazygit"

# Package management
alias update="sudo apt update && sudo apt upgrade -y && sudo snap refresh && nix-env --upgrade"
alias install="nix-env -iA nixpkgs.myPackages"

# Set dotfiles directory
alias dotfiles="/usr/bin/git --git-dir=$HOME/Workplace/dotfiles/ --work-tree=$HOME"

# ls
alias ls="ls --color=auto"
alias la="ls -lathr"

# -------------------- Sourcing --------------------
source $ZSH/oh-my-zsh.sh

source <(fzf --zsh)

# -------------------- Completion --------------------
autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select
