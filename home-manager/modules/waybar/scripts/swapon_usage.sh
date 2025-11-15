#!/usr/bin/env bash

get_percent() {
  used=$1
  total=$2
  if [ "$total" -eq 0 ]; then
    echo 0
  else
    echo $(( used * 100 / total ))
  fi
}

zram_line=$(swapon --noheadings --bytes | awk '/zram/')
swapfile_line=$(swapon --noheadings --bytes | awk '/swapfile/')

zram_size=$(echo "$zram_line" | awk '{print $3}')
zram_used=$(echo "$zram_line" | awk '{print $4}')
swapfile_size=$(echo "$swapfile_line" | awk '{print $3}')
swapfile_used=$(echo "$swapfile_line" | awk '{print $4}')

zram_percent=$(get_percent $zram_used $zram_size)
swapfile_percent=$(get_percent $swapfile_used $swapfile_size)

echo "{Z:${zram_percent}%|S:${swapfile_percent}%}"

