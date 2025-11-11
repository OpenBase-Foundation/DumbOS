# DumbOS - Minimal Android for Raspberry Pi (OpenBase)
# // Licensed under the OpenBase Software License (OBSL)
# // See LICENSE file in the project root for full license text.

Short quick-start
-----------------

This package contains simple installer and helper scripts to convert an Android image
(e.g. LineageOS for Raspberry Pi) into a minimal **DumbOS** that retains network
connectivity but removes Google services, telephony, and telemetry, and allows only
local APK installs (via USB or sideload).

Files
- `install.sh`   : Installs Dropbear (if possible), KISS launcher, and runs the cleaner.
- `dumbos_cleaner.sh` : Removes Google/telephony packages (best-effort) and toggles settings.
- `update.sh`    : Downloads the latest scripts from the repository and re-runs them.
- `LICENSE`      : License placeholder (OBSL).

Quick usage
1. Place this package on your Raspberry Pi (or run directly from the network).
2. From the Pi run (as root):
   ```sh
   curl -fsSL https://raw.githubusercontent.com/OpenBase-Foundation/DumbOS/main/install.sh | sh
   ```
3. Reboot after installation:
   ```sh
   reboot
   ```

Notes & safety
- These scripts are **best-effort** and designed for typical LineageOS/AOSP builds on Raspberry Pi.
- Some system apps cannot be uninstalled if they are baked into the system image.
- Always keep backups of important data and your original image.
- The installer may attempt to download binaries (dropbear) and an APK from F-Droid. Verify URLs if you wish.

If you publish a release image, you can add the `.img` to GitHub Releases and keep using the scripts for ongoing maintenance.
