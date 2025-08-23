#!/usr/bin/env bash

# Get per-core CPU usage
mpstat -P ALL 1 1 | awk '/Average:/ && $2 ~ /[0-9]+/ { printf("Core %s: %.1f%%\n", $2, 100 - $12) }'

