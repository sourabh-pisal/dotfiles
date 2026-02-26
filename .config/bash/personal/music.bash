# Add background music
bm-add() {
  local bm_dir="$HOME/.local/share/bm"
  local links_file="$bm_dir/links.txt"

  [[ ! -d "$bm_dir" ]] && mkdir -p "$bm_dir"

  # Add update a channel mapping
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: bm-add <channel-name> <channel-link>"
    return 1
  fi

  local channel="$1"
  local link="$2"

  # Remove old entry if it exists
  grep -v "^${channel}|" "$links_file" 2>/dev/null > "${links_file}.tmp" || true
  echo "${channel}|${link}" >> "${links_file}.tmp"
  mv "${links_file}.tmp" "$links_file"

  echo "Saved: $channel"
  return 0
}

# Play background music
bm-play() {
  local bm_dir="$HOME/.local/share/bm"
  local links_file="$bm_dir/links.txt"

  # --- Play mode (no args) ---
  if [[ ! -f "$links_file" || ! -s "$links_file" ]]; then
    echo "No saved channels yet. Add one using:"
    echo "bm-add <channel-name> <channel-link>"
    return 1
  fi

  # Use fzf to select channel
  local selection
  selection=$(awk -F'|' '{print $1}' "$links_file" | fzf --prompt="Select channel:" --height=10 --border --ansi)

  [[ -z "$selection" ]] && {
    return 1
  }

  local link
  link=$(grep "^${selection}|" "$links_file" | head -n1 | cut -d'|' -f2-)

  echo "Playing $selection"
  nohup mpv \
    --no-video \
    --really-quiet \
    "$link" >/dev/null 2>&1 &

  local pid=$!
  echo "$pid" > "$bm_dir/last_pid"

  disown
}

# Stop background music
bm-stop() {
  local pid_file="$HOME/.local/share/bm/last_pid"
  if [[ -f "$pid_file" ]]; then
    local pid
    pid=$(cat "$pid_file")
    if kill "$pid" 2>/dev/null; then
      rm -f "$pid_file"
    else
      echo "No bm-play process found."
    fi
  else
    echo "No bm-play process found."
  fi
}
