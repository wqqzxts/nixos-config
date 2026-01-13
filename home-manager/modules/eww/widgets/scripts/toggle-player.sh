#!/bin/bash

if [[ -z $(eww active-windows | grep 'media') ]]; then
	eww open media && eww update mediarev=true
else
	eww update mediarev=false
	(eww close media) &
fi
