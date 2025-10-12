# List audio outputs (sinks) one per line
list-outputs() {
  pactl list short sinks | awk '{print $2}'
}

# List audio inputs (sources) one per line
list-inputs() {
  pactl list short sources | awk '{print $2}'
}

# Set default output (sink)
set-default-output() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-default-output <sink-name>"
    return 1
  fi
  pactl set-default-sink "$1"
}

# Set default input (source)
set-default-input() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-default-input <source-name>"
    return 1
  fi
  pactl set-default-source "$1"
}

# Set volume for default output in percentage
set-output-volume() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-output-volume <volume-percent>"
    return 1
  fi
  pactl set-sink-volume @DEFAULT_SINK@ "$1%"
}

# Set volume for default input in percentage
set-input-volume() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-input-volume <volume-percent>"
    return 1
  fi
  pactl set-source-volume @DEFAULT_SOURCE@ "$1%"
}
