#!/bin/bash
set -e

REMOTE_USER="aa"
REMOTE_HOST="desktop"
REMOTE_PATH="/home/aa/development"
LOCAL_MOUNT="$HOME/remote-dev"

echo "[LOCAL] Killing ADB server and resetting..."
adb kill-server
adb start-server
adb wait-for-device

echo "[LOCAL] Checking for connected device..."
adb devices

echo
echo "==> Make sure your phone shows up and you've accepted USB debugging."
read -p "Press ENTER to continue if your phone shows as 'device'..."

echo "[LOCAL] Switching phone to TCP ADB mode on port 5555..."
adb tcpip 5555

echo "[LOCAL] Getting phone IP address..."
PHONE_IP=$(adb shell ip route | awk '{print $9}' | head -n 1)

echo "[LOCAL] Found phone IP: $PHONE_IP"
echo "==> Unplug the phone now."
read -p "Press ENTER when unplugged..."

# SSHFS mount
echo "[LOCAL] Mounting remote dev dir via sshfs..."
mkdir -p "$LOCAL_MOUNT"
sshfs "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}" "$LOCAL_MOUNT"

echo "[LOCAL] Mount complete. Now connecting to remote via SSH..."
ssh "${REMOTE_USER}@${REMOTE_HOST}"
