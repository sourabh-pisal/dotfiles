BASH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bash"

# Core - load in order (PATH first, then env, then prompt)
for f in \
    "$BASH_CONFIG_DIR/core/config.bash" \
    "$BASH_CONFIG_DIR/core/env.bash" \
    "$BASH_CONFIG_DIR/core/theme.bash"; do
    [[ -f "$f" ]] && source "$f"
done

# Rest - load all files in each group
for dir in aliases tools system personal; do
    for f in "$BASH_CONFIG_DIR/$dir/"*.bash; do
        [[ -f "$f" ]] && source "$f"
    done
done
