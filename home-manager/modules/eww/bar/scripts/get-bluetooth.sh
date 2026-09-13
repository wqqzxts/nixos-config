#!/bin/sh
emit() {
  if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    echo '{"status": "on"}'
  else
    echo '{"status": "off"}'
  fi
}

emit
dbus-monitor --system \
  "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/bluez/hci0'" 2>/dev/null \
  | grep --line-buffered '"Powered"' \
  | while read -r _; do emit; done
