#!/usr/bin/env bash

# Change this to your desired mount point, e.g., "/" or "/home"
MOUNT="/"

# Get disk usage info
USAGE=$(df -h --output=pcent,avail,size "$MOUNT" | tail -1)
PERCENT_USED=$(echo $USAGE | awk '{print $1}' | tr -d '%')
AVAILABLE=$(echo $USAGE | awk '{print $2}')
TOTAL=$(echo "$USAGE" | awk '{print $3}')

# Convert to numeric values to calculate used
AVAILABLE_NUM=$(df --output=avail "$MOUNT" | tail -1)
TOTAL_NUM=$(df --output=size "$MOUNT" | tail -1)
BLOCK_SIZE=$(df "$MOUNT" | awk 'NR==2 {print $2/$3}')  # In KB

USED_NUM=$((TOTAL_NUM - AVAILABLE_NUM))
USED=$(numfmt --to=iec --suffix=B $((USED_NUM * 1024)))
TOTAL_HR=$(numfmt --to=iec --suffix=B $((TOTAL_NUM * 1024)))
AVAILABLE_HR=$(numfmt --to=iec --suffix=B $((AVAILABLE_NUM * 1024)))

# Output JSON
# echo "{\"text\": \"${PERCENT_USED}%\", \"tooltip\": \"Free: ${AVAILABLE}B from ${TOTAL}B on ${MOUNT}\"}"
echo "{\"text\": \"${PERCENT_USED}%\", \"tooltip\": \"${USED} used, ${AVAILABLE_HR} free\"}"

