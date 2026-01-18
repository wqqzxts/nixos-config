#!/bin/sh

get_dnd_status() {
  if dunstctl is-paused | grep -q "true"; then
    echo '{"status": "on"}'
  else
    echo '{"status": "off"}'
  fi
}

get_dnd_status
