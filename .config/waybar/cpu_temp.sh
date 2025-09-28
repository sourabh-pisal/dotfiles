#!/bin/bash

for dir in /sys/class/hwmon/hwmon*; do
  name=$(cat "$dir/name" 2>/dev/null)
  if [[ "$name" == "k10temp" || "$name" == "coretemp" ]]; then
    if [[ -f "$dir/temp1_input" ]]; then
      temp=$(cat "$dir/temp1_input")
      echo "$((temp / 1000))°C"
      exit 0
    fi
  fi
done

echo ""

