#!/bin/sh

if dunstctl is-paused | grep -q "true"; then
  dunstctl set-paused false
else
  dunstctl set-paused true
fi
