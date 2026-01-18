#!/bin/sh

#!/bin/sh

get_current_layout() {
  layout_info=$(niri msg -j keyboard-layouts 2>/dev/null)
  current_idx=$(echo "$layout_info" | jq -r '.current_idx')
  layout_name=$(echo "$layout_info" | jq -r ".names[$current_idx]")

  case "$layout_name" in
    "English (US)") echo "US" ;;
    "Russian") echo "RU" ;;
    *) echo "${layout_name:0:2}" ;;
  esac
}

get_current_layout
