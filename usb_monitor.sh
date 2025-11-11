#!/system/bin/sh
# // Licensed under the OpenBase Software License (OBSL)
# // See LICENSE file in the project root for full license text.
#
# DumbOS USB Monitor
# Monitors for USB device insertion and automatically installs APK files found on the device.
# Run as: nohup /system/bin/sh /path/to/usb_monitor.sh > /dev/null 2>&1 &

set -e

LOG_FILE="/data/local/tmp/usb_monitor.log"
INSTALLED_APKS_FILE="/data/local/tmp/usb_installed_apks.txt"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

init_log() {
  mkdir -p "$(dirname "$LOG_FILE")"
  mkdir -p "$(dirname "$INSTALLED_APKS_FILE")"
  touch "$INSTALLED_APKS_FILE"
}

# Get list of mounted USB devices
get_usb_mount_points() {
  mount | grep -E 'vfat|exfat|ntfs|ext4' | grep -E '/mnt|/media|/storage' | awk '{print $3}' | grep -v '^/$'
}

# Find all APK files on a given path
find_apk_files() {
  local mount_point="$1"
  find "$mount_point" -type f -iname "*.apk" 2>/dev/null || true
}

# Install an APK and log the result
install_apk() {
  local apk_path="$1"
  
  # Check if already installed (by absolute path)
  if grep -q "^$apk_path$" "$INSTALLED_APKS_FILE" 2>/dev/null; then
    log "Already installed: $apk_path"
    return 0
  fi
  
  log "Installing APK: $apk_path"
  if pm install -r "$apk_path" >/dev/null 2>&1; then
    log "✅ Successfully installed: $apk_path"
    echo "$apk_path" >> "$INSTALLED_APKS_FILE"
    return 0
  else
    log "⚠️  Failed to install: $apk_path"
    return 1
  fi
}

# Scan and install APKs from all mounted USB devices
scan_and_install() {
  local usb_points=$(get_usb_mount_points)
  
  if [ -z "$usb_points" ]; then
    log "No USB devices currently mounted."
    return
  fi
  
  log "Found USB mount points: $usb_points"
  
  for mount_point in $usb_points; do
    log "Scanning $mount_point for APK files..."
    
    apk_files=$(find_apk_files "$mount_point")
    if [ -z "$apk_files" ]; then
      log "No APK files found in $mount_point"
      continue
    fi
    
    while IFS= read -r apk_file; do
      if [ -n "$apk_file" ] && [ -f "$apk_file" ]; then
        install_apk "$apk_file"
      fi
    done <<EOF
$apk_files
EOF
  done
}

# Monitor for mount/unmount events using inotifywait or polling
monitor_usb() {
  log "Starting USB monitor daemon..."
  log "USB Monitor will check for APKs every 5 seconds."
  
  previous_mounts=""
  
  while true; do
    current_mounts=$(get_usb_mount_points | sort)
    
    # Check if mounts have changed
    if [ "$current_mounts" != "$previous_mounts" ]; then
      if [ -n "$current_mounts" ]; then
        log "USB device(s) detected. Scanning for APK files..."
        scan_and_install
      fi
      previous_mounts="$current_mounts"
    fi
    
    sleep 5
  done
}

# Main entry point
init_log
log "=== DumbOS USB Monitor Started ==="
monitor_usb
