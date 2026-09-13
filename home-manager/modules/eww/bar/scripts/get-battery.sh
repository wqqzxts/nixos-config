#!/bin/sh
emit() {
  powerprofilesctl get 2>/dev/null || echo "balanced"
}

emit
dbus-monitor --system \
  "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/net/hadess/PowerProfiles'" 2>/dev/null \
  | grep --line-buffered '"ActiveProfile"' \
  | while read -r _; do emit; done
