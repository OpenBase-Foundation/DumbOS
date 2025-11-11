#!/system/bin/sh
# // Licensed under the OpenBase Software License (OBSL)
# // See LICENSE file in the project root for full license text.
#
# DumbOS Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/OpenBase-Foundation/DumbOS/main/install.sh | sh
#
set -e

REPO_RAW_BASE="https://raw.githubusercontent.com/OpenBase-Foundation/DumbOS/main"

echo "=== DumbOS Install Script ==="

# require root
if [ "$(id -u 2>/dev/null || echo 0)" -ne 0 ]; then
  echo "⚠️  This script must be run as root."
  exit 1
fi

# check internet connectivity
echo "[1/5] Checking network connectivity..."
if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
  echo "⚠️  No network connection detected. Please connect to the network and retry."
  exit 1
fi
echo "✅ Network OK."

TMPDIR="/data/local/tmp/dumbos_installer"
mkdir -p "$TMPDIR"
cd "$TMPDIR"

# download cleaner
echo "[2/5] Downloading dumbos_cleaner.sh..."
if curl -fsSL "$REPO_RAW_BASE/dumbos_cleaner.sh" -o dumbos_cleaner.sh; then
  chmod +x dumbos_cleaner.sh
  echo "✅ dumbos_cleaner.sh downloaded."
else
  echo "⚠️  Failed to download dumbos_cleaner.sh — aborting."
  exit 1
fi

# download usb monitor
echo "[2b/5] Downloading usb_monitor.sh..."
if curl -fsSL "$REPO_RAW_BASE/usb_monitor.sh" -o usb_monitor.sh; then
  chmod +x usb_monitor.sh
  echo "✅ usb_monitor.sh downloaded."
else
  echo "⚠️  Failed to download usb_monitor.sh — continuing anyway."
fi

# attempt to install Dropbear (lightweight SSH server)
echo "[3/5] Ensuring Dropbear SSH server is present..."
if ! command -v dropbear >/dev/null 2>&1; then
  if [ -w /system/xbin ]; then
    echo "➡️  Trying to download dropbear binary..."
    if curl -fsSL https://github.com/mkj/dropbear/releases/latest/download/dropbearmulti -o /system/xbin/dropbear; then
      chmod 0755 /system/xbin/dropbear || true
      echo "✅ Dropbear placed to /system/xbin/dropbear"
    else
      echo "⚠️  Could not fetch dropbear binary. You can install an SSH APK (SSHelper/Dropbear) manually."
    fi
  else
    echo "⚠️  /system/xbin not writable; skipping automatic dropbear install."
  fi
else
  echo "✅ Dropbear already present."
fi

# Download and install KISS Launcher from F-Droid (if space permits)
echo "[4/5] Downloading KISS Launcher APK..."
KISS_APK_URL="https://f-droid.org/repo/fr.neamar.kiss_405.apk"
if curl -fsSL -o kiss.apk "$KISS_APK_URL"; then
  if pm install -r kiss.apk >/dev/null 2>&1; then
    echo "✅ KISS Launcher installed."
  else
    echo "⚠️  KISS APK download succeeded but installation failed. You may install it manually."
  fi
else
  echo "⚠️  Failed to download KISS APK."
fi

# Run cleaner
echo "[5/5] Running dumbos_cleaner.sh..."
sh dumbos_cleaner.sh || true

# Start USB monitor daemon in background
echo ""
echo "[+] Starting USB monitor daemon..."
if [ -f usb_monitor.sh ]; then
  nohup sh "$TMPDIR/usb_monitor.sh" > /dev/null 2>&1 &
  echo "✅ USB monitor started. APKs on USB devices will auto-install when plugged in."
else
  echo "⚠️  USB monitor script not available."
fi

echo ""
echo "🎉 Install complete. Recommended: reboot the device."
echo "Run: reboot"
