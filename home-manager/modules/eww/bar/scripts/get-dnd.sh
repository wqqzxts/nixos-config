#!/bin/sh
emit() {
  if [ "$(dunstctl is-paused)" = "true" ]; then
    echo '{"status": "on"}'
  else
    echo '{"status": "off"}'
  fi
}

emit
dbus-monitor --session \
  "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/freedesktop/Notifications'" 2>/dev/null \
  | grep --line-buffered '"paused"' \
  | while read -r _; do emit; done
