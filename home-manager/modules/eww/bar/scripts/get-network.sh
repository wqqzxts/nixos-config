#!/bin/sh
emit() {
  wifi=$(nmcli -g WIFI general 2>/dev/null)
  essid=$(nmcli -t -f NAME,TYPE connection show --active 2>/dev/null \
          | awk -F: '$2 == "802-11-wireless" { print $1; exit }')
  wired=$(nmcli -t -f TYPE,STATE dev status 2>/dev/null | grep -q '^ethernet:connected' && echo true || echo false)
  signal=0
  if [ -n "$essid" ]; then
    signal=$(nmcli -g IN-USE,SIGNAL dev wifi list --rescan no 2>/dev/null \
             | awk -F: '$1 == "*" { print $2; exit }')
    signal=${signal:-0}
  fi
  jq -nc --arg wifi "${wifi:-disabled}" --argjson wired "$wired" --arg essid "$essid" --argjson signal "$signal" \
    '{wifi: $wifi, wired: $wired, essid: $essid, signal: $signal}'
}

emit
{
  nmcli monitor 2>/dev/null &
  while sleep 30; do echo tick; done
} | while read -r _; do emit; done
