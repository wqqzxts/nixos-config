#!/bin/sh
exec niri msg -j event-stream | jq -n --unbuffered -r '
  foreach inputs as $e (null;
    if $e.KeyboardLayoutsChanged then $e.KeyboardLayoutsChanged.keyboard_layouts
    elif $e.KeyboardLayoutSwitched then .current_idx = $e.KeyboardLayoutSwitched.idx
    else . end;
    if ($e.KeyboardLayoutsChanged or $e.KeyboardLayoutSwitched) then
      .names[.current_idx]
      | if . == "English (US)" then "US"
        elif . == "Russian" then "RU"
        else .[0:2] | ascii_upcase end
    else empty end)'
