# Bluetooth helper functions

bt-start() {
    echo "Starting Bluetooth service"
    sudo systemctl start bluetooth
    bluetoothctl power on
}

bt-stop() {
    bluetoothctl power off
    sudo systemctl stop bluetooth
    echo "Bluetooth stopped."
}

bt-status() {
    systemctl is-active bluetooth
    bluetoothctl show
}

bt-scan() {
    local timeout=${1:-10}
    echo "Scanning for $timeout seconds"

    local found
    found=$(bluetoothctl --timeout "$timeout" scan on 2>&1 | grep -E "^\[NEW\] Device" | awk '{print $3, substr($0, index($0,$4))}')
    echo ""

    echo "Devices found"
    if [ -z "$found" ]; then
        echo "No new devices found."
    else
        echo "$found"
    fi
}

bt-devices() {
    echo "Paired/known devices"
    bluetoothctl devices
}

bt-connect() {
    if [ -z "$1" ]; then
        echo "Usage: bt-connect <MAC>"
        bt-devices
        return 1
    fi
    bluetoothctl connect "$1"
}

bt-disconnect() {
    if [ -z "$1" ]; then
        echo "Usage: bt-disconnect <MAC>"
        bt-devices
        return 1
    fi
    bluetoothctl disconnect "$1"
}

bt-pair() {
    if [ -z "$1" ]; then
        echo "Usage: bt-pair <MAC>"
        return 1
    fi
    bluetoothctl pair "$1" && bluetoothctl trust "$1" && bluetoothctl connect "$1"
}

bt-remove() {
    if [ -z "$1" ]; then
        echo "Usage: bt-remove <MAC>"
        bt-devices
        return 1
    fi
    bluetoothctl remove "$1"
}

bt-help() {
    echo "Available Bluetooth commands:"
    echo "  bt-start               - Start service and power on"
    echo "  bt-stop                - Power off and stop service"
    echo "  bt-status              - Show service status and adapter info"
    echo "  bt-scan [seconds]      - Scan for nearby devices (default: 10s)"
    echo "  bt-devices             - List paired/known devices"
    echo "  bt-connect <MAC>       - Connect to a device"
    echo "  bt-disconnect <MAC>    - Disconnect a device"
    echo "  bt-pair <MAC>          - Pair, trust and connect a device"
    echo "  bt-remove <MAC>        - Remove/unpair a device"
}
