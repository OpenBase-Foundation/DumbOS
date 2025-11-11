## DumbOS — Minimal Android for Raspberry Pi (OpenBase)

A small collection of helper scripts and an installer that convert a Raspberry Pi Android/LineageOS image
into a minimal, privacy-focused environment ("DumbOS"). The intent is to remove Google/telemetry/telephony
components and to keep the system usable for local APK installs and simple devices.

Latest image
------------

The latest prebuilt image (if available) is published on this repository's **Releases** page:

https://github.com/OpenBase-Foundation/DumbOS/releases

Look for the `.img` (or other archive) in the latest release assets. Whenever possible we recommend
downloading the release image and the matching checksum file and verifying the checksum before flashing.

Quick overview
--------------

There are two common ways to get DumbOS running:

- **Flash a prebuilt image** (recommended if you want a ready-to-run SD card).
- **Flash a stock Android/LineageOS image**, boot it, then run the `install.sh` script on-device to remove
  unwanted packages and apply the "DumbOS" changes.

Files in this repo
------------------

- `install.sh` — installer script. Installs small utilities (where possible) and runs the cleaner.
- `dumbos_cleaner.sh` — the cleanup logic that removes or disables Google/telephony/telemetry packages (best-effort).
- `update.sh` — fetches the latest scripts from this repository and re-runs them.
- `LICENSE` — license for the project.

Flashing a released image
-------------------------

1. Download the latest `.img` from the [Releases](https://github.com/OpenBase-Foundation/DumbOS/releases) page above.

2. Verify the checksum (recommended):

```sh
# on Linux/macOS
sha256sum dumbos-<version>.img
# compare against released .sha256 or .sha256sum file
```

3. Flash to SD card — examples:

**Windows:** Use [balenaEtcher](https://www.balena.io/etcher/) or Rufus and select the downloaded `.img`.

**Linux/macOS:** (dd example — be VERY careful and replace `/dev/sdX` with your actual device):

```sh
sudo dd if=dumbos-<version>.img of=/dev/sdX bs=4M status=progress conv=fsync
sync
```

Running the installer on-device
-------------------------------

If you already have a compatible Android/LineageOS image installed on the Pi, you can run the installer
scripts from this repo on the device. Example (run as root or via adb shell):

```sh
curl -fsSL https://raw.githubusercontent.com/OpenBase-Foundation/DumbOS/main/install.sh | sh
```

This will attempt to apply the cleaner and optionally install small utilities like Dropbear where feasible.
It is best-effort and depends on the specific build of Android — some system apps cannot be removed if
they are baked into the system image.

Security & safety
-----------------

- Always backup your data and keep a copy of the original image before making changes.
- Verify release checksums before flashing images from Releases.
- These scripts may download small helper binaries or APKs from third-party sources; review the script
  and URLs before running them.
- This project is provided as-is. Use in test environments first.

Contributing
------------

Contributions are welcome. Please open issues for bugs or feature requests. For code contributions, send a
pull request against the `main` branch and describe the rationale.

License
-------

See the `LICENSE` file in the project root for licensing details. This project is licensed under the OpenBase Software License (OBSL).
