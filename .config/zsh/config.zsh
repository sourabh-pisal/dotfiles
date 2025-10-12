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

# File to save command history
HISTFILE=~/.histfile

# Number of commands to remember in memory and save to file
HISTSIZE=1000
SAVEHIST=1000

# History behavior options
setopt HIST_IGNORE_SPACE    # Ignore commands prefixed with a space
setopt HIST_IGNORE_DUPS     # Ignore duplicate entries
setopt SHARE_HISTORY        # Share history across sessions
