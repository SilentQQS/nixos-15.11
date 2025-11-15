#!/usr/bin/env bash
device="wlan0"
RX=/sys/class/net/$device/statistics/rx_bytes
TX=/sys/class/net/$device/statistics/tx_bytes
INTERVAL=1

bandwidth() {
    local prev_rx="$(cat "$RX")"
    local prev_tx="$(cat "$TX")"
    while true; do
        sleep $INTERVAL
        local rx="$(cat "$RX")"
        local tx="$(cat "$TX")"
        local rxps=$(((rx - prev_rx) / INTERVAL))
        local txps=$(((tx - prev_tx) / INTERVAL))
        prev_rx="$rx"
        prev_tx="$tx"
        local rx_fmt=$(printf "%4s" "$(numfmt --to=si $rxps)")
        local tx_fmt=$(printf "%4s" "$(numfmt --to=si $txps)")

        rx_fmt="${rx_fmt// /_}"
        tx_fmt="${tx_fmt// /_}"

        printf "RX:%s TX:%s\n" "$rx_fmt" "$tx_fmt"
    done
}
printf "RX:___0 TX:___0\n"
bandwidth
