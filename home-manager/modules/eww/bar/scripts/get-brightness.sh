#!/bin/sh

brightnessctl -m 2>/dev/null | cut -d, -f4 | tr -d '%' || echo "0"

inotifywait -m -e modify /sys/class/backlight/*/brightness 2>/dev/null | while read -r _; do
    sleep 0.1
    brightnessctl -m 2>/dev/null | cut -d, -f4 | tr -d '%' || echo "0"
done
