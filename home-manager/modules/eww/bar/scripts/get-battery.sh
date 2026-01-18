#!/bin/sh

get_power_profile() {
  powerprofilesctl get 2>/dev/null || echo "balanced"
}

get_power_profile

dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/net/hadess/PowerProfiles'" 2>/dev/null | \
  while read -r _; do
    get_power_profile
  done
