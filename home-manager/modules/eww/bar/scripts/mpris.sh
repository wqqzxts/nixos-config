#!/bin/sh
base_dir="/tmp/eww-covers"
US=$(printf '\037')
prev_art=""

playerctl metadata -F -f "{{playerName}}${US}{{title}}${US}{{artist}}${US}{{mpris:artUrl}}${US}{{status}}${US}{{mpris:length}}${US}{{duration(mpris:length)}}" 2>/dev/null \
| while IFS="$US" read -r name title artist artUrl status length lengthStr; do
    [ -n "$length" ] && length=$((length / 1000000))

    cover=""
    if [ -n "$artUrl" ]; then
      cover="$base_dir/image.jpg"
      if [ "$artUrl" != "$prev_art" ]; then
        prev_art=$artUrl
        mkdir -p "$base_dir"
        case "$artUrl" in
          file://*) cp -f "${artUrl#file://}" "$cover" 2>/dev/null ;;
          *)        wget -q -O "$cover" "$artUrl" 2>/dev/null & ;;
        esac
      fi
    fi

    jq -nc --arg name "$name" --arg title "$title" --arg artist "$artist" \
           --arg artUrl "$cover" --arg status "$status" \
           --arg length "$length" --arg lengthStr "$lengthStr" \
      '{name: $name, title: $title, artist: $artist, artUrl: $artUrl, status: $status, length: $length, lengthStr: $lengthStr}'
done
