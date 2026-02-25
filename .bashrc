#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source bash config files
source ~/.config/bash/aliases
source ~/.config/bash/audio
source ~/.config/bash/config
source ~/.config/bash/env
source ~/.config/bash/fzf
source ~/.config/bash/homebrew
source ~/.config/bash/music
source ~/.config/bash/networking
source ~/.config/bash/owncloud
source ~/.config/bash/package_management
source ~/.config/bash/tailscale
source ~/.config/bash/theme

# Start sway
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    Exec=env WLR_RENDERER=vulkan sway
fi
