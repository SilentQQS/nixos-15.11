#!/usr/bin/env bash

# Get a list of all real Sinks in ID:Name format, ignoring Easy Effects
mapfile -t SINKS < <(
    wpctl status \
    | awk '/Sinks:/,/Sources:/ {print}' \
    | grep -v 'Easy Effects' \
    | grep -E '^\s*│' \
    | sed 's/│//; s/\*//; s/\[vol:.*\]//; s/^[[:space:]]*//' \
    | awk 'NF && $1 ~ /^[0-9]+\./ {split($1,a,"."); id=a[1]; $1=""; name=$0; gsub(/^ +| +$/,"",name); print id ":" name}'
)

# Check for at least 2 outputs
if [ ${#SINKS[@]} -lt 2 ]; then
    notify-send "Audio switch" "Not enough sinks to switch!"
    exit 1
fi

# Get the current default Sink ID and Name
# We now get the ID and name directly from wpctl status
CURRENT_ID_AND_NAME=$(wpctl status | grep -E '^\s*│.*\*\s' | awk '{split($1,a,"."); print a[1]":"$0}' | sed 's/\[vol:.*//')
CURRENT_ID="${CURRENT_ID_AND_NAME%%:*}"

# Determine the next output (cyclically)
NEXT_ID=""
NEXT_NAME=""
FOUND_CURRENT=false
for entry in "${SINKS[@]}"; do
    ID="${entry%%:*}"
    NAME="${entry#*:}"

    if [ "$FOUND_CURRENT" = true ]; then
        NEXT_ID="$ID"
        NEXT_NAME="$NAME"
        break
    fi

    if [ "$ID" = "$CURRENT_ID" ]; then
        FOUND_CURRENT=true
    fi
done

# If the current was the last in the list, switch to the first
if [ -z "$NEXT_ID" ]; then
    FIRST_ENTRY="${SINKS[0]}"
    NEXT_ID="${FIRST_ENTRY%%:*}"
    NEXT_NAME="${FIRST_ENTRY#*:}"
fi

# Change the default output
wpctl set-default "$NEXT_ID"

# Send a notification
notify-send "Audio switched" "Current output: $NEXT_NAME"
