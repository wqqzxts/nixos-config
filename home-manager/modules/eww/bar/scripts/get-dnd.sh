#!/bin/sh

get_dnd_status() {
  if dunstctl is-paused | grep -q "true"; then
    echo '{"status": "on"}'
  else
    echo '{"status": "off"}'
  fi
}

get_dnd_status

dbus-monitor "path='/org/freedesktop/Notifications',interface='org.freedesktop.DBus.Properties'" 2>/dev/null | \
  while read -r line; do
    get_dnd_status
  done
