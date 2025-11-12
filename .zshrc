# Path to config directory
ZSH_CONFIG="$HOME/.config/zsh"

# Load environment variables from the .env file if it exists
if [ -f ~/.env ]; then
  export $(grep -v '^#' ~/.env | xargs)
fi

# Source all core scripts
for file in $ZSH_CONFIG/{config,env,aliases}.zsh; do
  [ -r "$file" ] && source "$file"
done

# Load any functions automatically
for file in $ZSH_CONFIG/functions/*.zsh; do
  [ -r "$file" ] && source "$file"
done

# Load any custom scripts automatically
for file in $ZSH_CONFIG/custom/*.zsh; do
  [ -r "$file" ] && source "$file"
done

# Load function/alias for music
for file in $ZSH_CONFIG/music.zsh; do
  [ -r "$file" ] && source "$file"
done

# Start sway
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    exec sway
fi
