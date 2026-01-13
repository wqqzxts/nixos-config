#!/bin/bash

if [[ -z $(eww active-windows | grep 'toggle-cpu-profile') ]]; then
    eww open toggle-cpu-profile && eww update tgcrev=true
else
    eww update tgcrev=false
    (eww close toggle-cpu-profile) &
fi
