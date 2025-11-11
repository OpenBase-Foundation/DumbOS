#!/system/bin/sh
# // Licensed under the OpenBase Software License (OBSL)
# // See LICENSE file in the project root for full license text.
#
# DumbOS Cleaner Script
# Strips Google/telemetry/telephony packages and enables local APK installs.
#
echo "=== DumbOS Cleaner started ==="

# Helper to try uninstalling a package (silently)
try_uninstall() {
  pkg="$1"
  if pm list packages | grep -q "$pkg"; then
    echo "Removing $pkg..."
    pm uninstall --user 0 "$pkg" >/dev/null 2>&1 || echo "Note: could not uninstall $pkg (may be part of system image)."
  fi
}

# 1) Remove known Google & smart components (best-effort)
echo "[1/4] Removing Google & smart components..."
try_uninstall com.google.android.gms
try_uninstall com.google.android.gsf
try_uninstall com.google.android.tts
try_uninstall com.google.android.apps.turbo
try_uninstall com.google.android.backuptransport
try_uninstall com.google.android.syncadapters.contacts
try_uninstall com.google.android.syncadapters.calendar
try_uninstall com.android.voicesearch
try_uninstall com.google.android.calendar
try_uninstall com.android.dialer
try_uninstall com.android.messaging
try_uninstall com.android.contacts
try_uninstall com.android.providers.contacts
try_uninstall com.google.android.marvin.talkback

echo "✅ Attempted removal of common smart/Google packages."

# 2) Disable telemetry & backup
echo "[2/4] Disabling telemetry and backup..."
settings put global send_action_app_error 0 2>/dev/null || true
settings put secure backup_enabled 0 2>/dev/null || true
settings put global usage_stats_enabled 0 2>/dev/null || true
settings put global package_verifier_enable 0 2>/dev/null || true
settings put secure location_providers_allowed "" 2>/dev/null || true
echo "✅ Telemetry/preferences adjusted (best-effort)."

# 3) Enable ADB & allow non-market installs (for USB APK installs)
echo "[3/4] Enabling ADB and non-market APK installs..."
settings put global adb_enabled 1 2>/dev/null || true
# Some Android versions use INSTALL_NON_MARKET_APPS setting in secure
settings put secure install_non_market_apps 1 2>/dev/null || settings put global install_non_market_apps 1 2>/dev/null || true
echo "✅ ADB and non-market installs enabled (if supported by ROM)."

# 4) Set lightweight launcher as home (if installed)
echo "[4/4] Setting lightweight launcher (if present)..."
if pm list packages | grep -q "fr.neamar.kiss"; then
  echo "Setting KISS as home launcher..."
  cmd package set-home-activity fr.neamar.kiss/.MainActivity >/dev/null 2>&1 || true
  echo "✅ KISS set as home."
else
  echo "⚠️ KISS not found. Please install a lightweight launcher (KISS/Niagara) to improve UX."
fi

echo "=== DumbOS Cleaner finished ==="
