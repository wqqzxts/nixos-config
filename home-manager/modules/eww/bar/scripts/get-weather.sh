#!/bin/sh

# temperature|feels-like|condition|wind|uv-index
weather_data=$(curl -s "wttr.in/Irkutsk?m&format=%t+%f+%C+%w+%u")

temp=$(echo "$weather_data" | awk '{print $1}' | sed 's/°C//')
ftemp=$(echo "$weather_data" | awk '{print $2}' | sed 's/°C//')

wind_raw=$(echo "$weather_data" | awk '{print $(NF-1)}')  # Second to last field
uv=$(echo "$weather_data" | awk '{print $NF}')  # Last field

condition=$(echo "$weather_data" | awk '{for(i=3;i<=NF-2;i++) printf "%s ", $i}' | sed 's/ $//')

# convert wind speed to m/s
wind_kmh=$(echo "$wind_raw" | sed 's/[^0-9]//g')
wind=$(echo "scale=1; $wind_kmh / 3.6" | bc)

echo "{\"temp\":\"$temp\", \"ftemp\":\"$ftemp\", \"condition\":\"$condition\", \"wind\":\"$wind\", \"uv\":\"$uv\"}"
