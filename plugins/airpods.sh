#!/bin/bash

# Define the AirPods name
AIRPODS_NAME="GweniPods"

# Fetch the Bluetooth status for the AirPods
AIRPODS_STATUS=$(system_profiler SPBluetoothDataType | awk '/Connected:/,/Not Connected:/ {if ($0 !~ /Not Connected:/) print}' | grep "$AIRPODS_NAME")


# Define the AirPods icon
ICON="􀪷"  # AirPods icon

# Check if the AirPods are connected
if [[ "$AIRPODS_STATUS" != "" ]]; then
  # AirPods are connected
  CONNECTION_STATUS="$AIRPODS_NAME"
else
  # AirPods are not connected
  ICON=""
fi

# Update the SketchyBar item
sketchybar --set "$NAME" icon="$ICON" label="$CONNECTION_STATUS"

