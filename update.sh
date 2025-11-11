#!/system/bin/sh
# // Licensed under the OpenBase Software License (OBSL)
# // See LICENSE file in the project root for full license text.
#
# DumbOS Updater
# This script pulls the latest installer/cleaner from the repository and (re)runs the installer.
#
REPO_RAW_BASE="https://raw.githubusercontent.com/OpenBase-Foundation/DumbOS/main"

echo "=== DumbOS Updater ==="

TMPDIR="/data/local/tmp/dumbos_update"
mkdir -p "$TMPDIR"
cd "$TMPDIR"

echo "[1/3] Downloading latest scripts..."
curl -fsSL "$REPO_RAW_BASE/dumbos_cleaner.sh" -o dumbos_cleaner.sh || { echo "Failed to download dumbos_cleaner.sh"; exit 1; }
curl -fsSL "$REPO_RAW_BASE/install.sh" -o install.sh || { echo "Failed to download install.sh"; exit 1; }
chmod +x dumbos_cleaner.sh install.sh || true

echo "[2/3] Running cleaner..."
sh dumbos_cleaner.sh || true

echo "[3/3] Running installer (non-destructive)..."
sh install.sh || true

echo "✅ Update complete. Consider rebooting the device."
echo "Run: reboot"
