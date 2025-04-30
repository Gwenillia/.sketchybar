#!/bin/bash

STATE_FILE="/tmp/pomodoro_state"
PAUSE_FILE="/tmp/pomodoro_pause"

if [[ -f "$PAUSE_FILE" ]]; then
  rm "$PAUSE_FILE"
else
  touch "$PAUSE_FILE"
fi

