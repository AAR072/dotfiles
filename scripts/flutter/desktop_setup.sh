#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <phone_ip_or_hostname>"
  exit 1
fi

PHONE_IP=$1

echo "[REMOTE] Connecting to phone at $PHONE_IP:5555..."
adb connect "$PHONE_IP:5555"

echo "[REMOTE] Verifying device connection..."
adb devices

echo "[REMOTE] Starting flutter run..."
flutter run
