#!/bin/sh

get_bluetooth_status() {
  if bluetoothctl show | grep -q "Powered: yes"; then
    echo '{"status": "on"}'
  else
    echo '{"status": "off"}'
  fi
}

get_bluetooth_status

while true; do
  inotifywait -e modify /sys/class/bluetooth/*/powered 2>/dev/null
  get_bluetooth_status
done
