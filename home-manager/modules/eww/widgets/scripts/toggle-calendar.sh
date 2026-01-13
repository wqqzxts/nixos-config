#!/bin/bash
if [[ -z $(eww active-windows | grep 'calendar') ]]; then
    eww open calendar && eww update calrev=true
else
    eww update calrev=false
    (eww close calendar) &
fi
