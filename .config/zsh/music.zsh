# play youtube in background
yt-bg() {
  local yt_bg_dir="$HOME/.local/share/yt-bg"
  [[ ! -d "$yt_bg_dir" ]] && mkdir -p "$yt_bg_dir"

  local last_link_file="$yt_bg_dir/last_link.txt"

  # If a link is provided, use it and save as last played
  if [[ -n "$1" ]]; then
    local ytlink="$1"
    echo "$ytlink" > "$last_link_file"
  else
    # If no link is provided, try to read the last played link
    if [[ -f "$last_link_file" ]]; then
      local ytlink
      ytlink=$(<"$last_link_file")
    else
      echo "Usage: yt-bg <youtube-link>"
      return 1
    fi
  fi

  nohup mpv \
    --no-video \
    --really-quiet \
    "$ytlink" >/dev/null 2>&1 &

  local pid=$!
  echo "$pid" > "$yt_bg_dir/last_pid"

  disown 
}

yt-bg-stop() {
  local pid_file="$HOME/.local/share/yt-bg/last_pid"
  if [[ -f "$pid_file" ]]; then
    local pid
    pid=$(cat "$pid_file")
    if kill "$pid" 2>/dev/null; then
      rm -f "$pid_file"
    else
      echo "No yt-bg process found."
    fi
  else
    echo "No yt-bg process found."
  fi
}
