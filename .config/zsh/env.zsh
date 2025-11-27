# Set the default editor
set -o vi

export VISUAL=nvim
export EDITOR=nvim
export TERM=xterm-256color

# Node.js
export JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=1

# Use wayland for electron apps
export ELECTRON_OZONE_PLATFORM_HINT=wayland
