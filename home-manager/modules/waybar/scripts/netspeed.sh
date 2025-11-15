#!/usr/bin/env bash

interface="wlp2s0" 

rx_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
tx_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)

sleep 1

rx_bytes_new=$(cat /sys/class/net/$interface/statistics/rx_bytes)
tx_bytes_new=$(cat /sys/class/net/$interface/statistics/tx_bytes)

rx_speed=$(( rx_bytes_new - rx_bytes ))
tx_speed=$(( tx_bytes_new - tx_bytes ))

rx_mb=$(echo "scale=2; $rx_speed / 1000000" | bc)
tx_mb=$(echo "scale=2; $tx_speed / 1000000" | bc)

if [ $(echo "$rx_mb < 1" | bc) -eq 1 ]; then
    rx_display=$(printf "%.2fM" "$rx_mb")
else
    rx_display=$(printf "%.1fM" "$rx_mb")
fi

if [ $(echo "$tx_mb < 1" | bc) -eq 1 ]; then
    tx_display=$(printf "%.2fM" "$tx_mb")
else
    tx_display=$(printf "%.1fM" "$tx_mb")
fi

printf "U:%5s|D:%5s\n" "$tx_display" "$rx_display"
