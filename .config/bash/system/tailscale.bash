# start tailscale
tailscale-connect() {
  sudo systemctl start tailscaled.service
  sudo tailscale up
}

# stop tailscale
tailscale-disconnect() {
  sudo tailscale down
  sudo systemctl stop tailscaled.service
}
