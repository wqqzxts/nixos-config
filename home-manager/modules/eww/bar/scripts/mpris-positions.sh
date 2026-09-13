#!/bin/sh
US=$(printf '\037')
ticker=""

emit() {
  playerctl metadata -f "{{playerName}}${US}{{position}}${US}{{duration(position)}}" 2>/dev/null \
  | { IFS="$US" read -r player pos posStr
      [ -n "$player" ] || exit 0
      jq -nc --arg player "$player" --arg position "$(( ${pos:-0} / 1000000 ))" --arg positionStr "${posStr:-0:00}" \
        '{($player): {position: $position, positionStr: $positionStr}}'
    }
}

stop_ticker() {
  [ -n "$ticker" ] && kill "$ticker" 2>/dev/null
  ticker=""
}

playerctl metadata -F -f "{{playerName}}${US}{{status}}" 2>/dev/null \
| {
  trap 'stop_ticker' EXIT INT TERM
  while IFS="$US" read -r _ status; do
    stop_ticker
    emit
    if [ "$status" = "Playing" ]; then
      { while :; do emit; sleep 1; done; } &
      ticker=$!
    fi
  done
}
