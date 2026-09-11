#!/usr/bin/env bash
# If more than one output is connected, we're "docked" — just turn off the panel.
# Otherwise, no external monitor — lock and suspend like normal.
count=$(niri msg outputs | grep -c '^Output ')

if [ "$count" -gt 1 ]; then
    niri msg output "eDP-1" off
    niri msg action focus-monitor "DP-7"
else
    noctalia msg session lock-and-suspend
fi
