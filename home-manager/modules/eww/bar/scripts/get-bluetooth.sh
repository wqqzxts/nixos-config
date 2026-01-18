#!/bin/sh

get_bluetooth_status() {
  if bluetoothctl show | grep -q "Powered: yes"; then
    echo '{"status": "on"}'
  else
    echo '{"status": "off"}'
  fi
}

get_bluetooth_status

dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/bluez/hci0'" 2>/dev/null | \
  while read -r _; do
    get_bluetooth_status
  done
