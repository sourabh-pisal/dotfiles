# Connect to Wi-Fi by SSID (with optional password)
connect-wifi() {
  if [[ -n "$1" ]]; then
    local ssid="$1"
    local pass="$2"
    echo "Connecting to Wi-Fi: $ssid ..."
    if [[ -n "$pass" ]]; then
      nmcli device wifi connect "$ssid" password "$pass"
    else
      nmcli device wifi connect "$ssid"
    fi
  else
    echo "Usage: connect-wifi <SSID> [password]"
  fi
}

# Disconnect from current Wi-Fi
disconnect-wifi() {
  local iface
  iface=$(nmcli -t -f DEVICE,TYPE d | awk -F: '$2=="wifi"{print $1; exit}')
  if [[ -n "$iface" ]]; then
    echo "Disconnecting Wi-Fi on interface $iface ..."
    nmcli device disconnect "$iface"
  else
    echo "No Wi-Fi interface found."
  fi
}

# List available Wi-Fi networks
list-wifi() {
  echo "Scanning for available Wi-Fi networks..."
  nmcli device wifi list
}
