#!/bin/bash

# Config
WORK_DURATION=$((25 * 60)) # 25 minutes
BREAK_DURATION=$((5 * 60)) # 5 minutes
POMODORO_ICON="🍅"

# Where we'll store the state
STATE_FILE="/tmp/pomodoro_state"

# If state doesn't exist, initialize
if [[ ! -f "$STATE_FILE" ]]; then
  echo "work:$WORK_DURATION" > "$STATE_FILE"
fi

# Read current state
IFS=":" read -r MODE TIME_LEFT < "$STATE_FILE"

# Decrement time
TIME_LEFT=$((TIME_LEFT - 1))

# Switch mode if needed
if (( TIME_LEFT <= 0 )); then
  if [[ "$MODE" == "work" ]]; then
    MODE="break"
    TIME_LEFT=$BREAK_DURATION
    terminal-notifier -title "Pomodoro" -message "Break time! ☕" -sound default
  else
    MODE="work"
    TIME_LEFT=$WORK_DURATION
    terminal-notifier -title "Pomodoro" -message "Back to work 💻" -sound default
  fi
fi

# Save state
echo "$MODE:$TIME_LEFT" > "$STATE_FILE"

# Format timer
MINUTES=$((TIME_LEFT / 60))
SECONDS=$((TIME_LEFT % 60))
TIMER=$(printf "%02d:%02d" "$MINUTES" "$SECONDS")

# Pause check
PAUSE_FILE="/tmp/pomodoro_pause"

if [[ -f "$PAUSE_FILE" ]]; then
  sketchybar --set pomodoro label="⏸ Paused"
  exit 0
fi

# Send update to SketchyBar
sketchybar --set pomodoro icon="$POMODORO_ICON" \
           --set pomodoro label="$TIMER" \
