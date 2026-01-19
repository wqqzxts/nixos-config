#!/bin/sh

if eww active-windows | grep -q "ewwbar"; then
    eww close ewwbar && eww close window-power && eww close window-clock && eww close window-weather && eww close window-cava && eww close window-language && eww close window-status && eww close window-status && eww close window-battery
else
    eww open ewwbar && eww open window-power && eww open window-clock && eww open window-weather && eww open window-cava && eww open window-language && eww open window-status && eww open window-status && eww open window-battery
fi
