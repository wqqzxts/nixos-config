#!/bin/sh
if [ "$(nmcli -g WIFI general)" = "enabled" ]; then
  nmcli radio wifi off
else
  nmcli radio wifi on
fi
