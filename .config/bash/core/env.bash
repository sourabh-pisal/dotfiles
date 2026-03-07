# Set the default editor
set -o vi

export EDITOR=$(command -v nvim >/dev/null 2>&1 && echo nvim || echo vim)
export VISUAL=$EDITOR
export TERM=xterm-256color

# Node.js
export JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=1

# Use wayland for electron apps
export ELECTRON_OZONE_PLATFORM_HINT=wayland
