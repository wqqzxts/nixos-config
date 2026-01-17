#!/bin/sh

if bluetoothctl show | grep -q "Powered: yes"; then
    echo "on"
else
    echo "off"
fi
