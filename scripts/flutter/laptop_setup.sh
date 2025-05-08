#!/bin/bash
set -e

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

echo "[LOCAL] Test connecting from remote via: adb connect $PHONE_IP:5555"
echo "You can now SSH to the remote and run the remote script."

echo
echo "[OPTIONAL] Copying remote_run.sh to remote machine..."
scp ./remote_run.sh youruser@remote-host:~/flutter-phone-dev/remote_run.sh

echo "[DONE] Now SSH in and run: bash ~/flutter-phone-dev/remote_run.sh $PHONE_IP"
