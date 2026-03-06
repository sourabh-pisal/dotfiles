# Bluetooth helper functions

bt-start() {
    sudo systemctl start bluetooth
    bluetoothctl power on
}

bt-stop() {
    bluetoothctl power off
    sudo systemctl stop bluetooth
}

bt-status() {
    systemctl is-active bluetooth
    bluetoothctl show
}

bt-scan() {
    local timeout=10

    local found
    found=$(bluetoothctl --timeout "$timeout" scan on 2>&1 | sed 's/\x1b\[[0-9;]*m//g' | grep -E "^\[NEW\] Device" | awk '{print $3, substr($0, index($0,$4))}')

    echo "$found"
}

bt-devices() {
    bluetoothctl devices
}

_bt-pick-device() {
    local prompt="${1:-Select device: }"
    local selected
    selected=$(bluetoothctl devices | grep "^Device " | fzf --prompt="$prompt" --height=10 --reverse)
    [ -z "$selected" ] && return 1
    echo "$selected" | awk '{print $2}'
}

bt-connect() {
    local mac="${1:-$(_bt-pick-device "Connect to: ")}" || return 1
    bluetoothctl connect "$mac"
}

bt-disconnect() {
    local mac="${1:-$(_bt-pick-device "Disconnect: ")}" || return 1
    bluetoothctl disconnect "$mac"
}

bt-pair() {
    local mac="$1"
    if [ -z "$mac" ]; then
        local timeout=10
        local selected
        selected=$(bt-scan "$timeout" | fzf --prompt="Pair device: " --height=20 --reverse)
        [ -z "$selected" ] && return 1
        mac=$(echo "$selected" | awk '{print $1}')
    fi
    bluetoothctl pair "$mac" && bluetoothctl trust "$mac" && bluetoothctl connect "$mac"
}

bt-remove() {
    local mac="${1:-$(_bt-pick-device "Remove device: ")}" || return 1
    bluetoothctl remove "$mac"
}
