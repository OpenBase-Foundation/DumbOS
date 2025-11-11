# Changelog

All notable changes to the DumbOS project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]
- Prepare `1.0.0` release (to be published soon)

---

## [1.1.0] - 2025-11-11

### Added
- **USB Auto-Install Feature**: New background daemon that detects USB device insertion and automatically installs APK files found on the device
  - `usb_monitor.sh`: Background daemon that monitors for USB insertion and auto-installs APKs
  - `99-dumbos-usb-monitor`: init.d script that auto-starts the USB monitor on every boot
  - USB monitor works automatically on boot without requiring the installer to be run
  - Installation events are logged to `/data/local/tmp/usb_monitor.log`
  - Prevents duplicate installations of the same APK

### Changed
- **Improved README**: Restructured and clarified documentation
  - Added dedicated "Latest image" section pointing to GitHub Releases
  - Added separate sections for flashing prebuilt images vs. running installer
  - Added platform-specific flashing instructions (Windows, Linux, macOS)
  - Added "USB auto-install" feature documentation
  - Improved "Security & safety" section with checksum verification guidance
  - Added "Contributing" section

### Enhanced
- **install.sh**: Now downloads and deploys USB monitor
  - Downloads `usb_monitor.sh` from repository
  - Downloads and installs `99-dumbos-usb-monitor` init.d script
  - Copies scripts to system directories for automatic startup
  - Better status messages during installation

### Technical Details
- USB monitor checks mounted filesystems every 5 seconds
- Recursively scans USB drives for `.apk` files
- Uses `pm install` for silent APK installation
- Tracks installed APKs to prevent reinstallation
- Logs all activity with timestamps for troubleshooting

---

## [1.0.0] - (planned)

### Initial Release (planned)

This release is being prepared and will be published soon as `1.0.0`.

#### Included (planned)
- `install.sh`: Main installer script for setting up DumbOS
- `dumbos_cleaner.sh`: Removes Google/telemetry/telephony packages
- `update.sh`: Fetches latest scripts from repository
- `LICENSE`: OpenBase Software License (OBSL) v1.0

More details and an official release date will be published when the release is published.

---

## Version History Summary

| Version | Date       | Release Type | Key Feature |
|---------|-----------|--------------|------------|
| 1.1.0   | 2025-11-11 | Minor        | USB Auto-Install + Improved Docs |
| 1.0.0   | 2025-11-11 | Initial      | Core DumbOS System |

---

## Installation & Upgrade

### Fresh Installation (First Time)
```sh
curl -fsSL https://raw.githubusercontent.com/OpenBase-Foundation/DumbOS/main/install.sh | sh
```

### Updating to Latest Version
```sh
curl -fsSL https://raw.githubusercontent.com/OpenBase-Foundation/DumbOS/main/update.sh | sh
```

---

## Known Issues & Limitations

- Some system apps cannot be uninstalled if they are baked into the system image
- Dropbear installation may fail on some ROMs without writable `/system/xbin`
- USB monitor requires standard Linux mount points (`/mnt`, `/media`, `/storage`)
- Init.d script requires writable `/system/etc/init.d` directory for auto-start

---

## Future Roadmap

- [ ] Support for more app stores (Aurora Store, Obtainium, etc.)
- [ ] Enhanced USB detection using inotifywait if available
- [ ] Web-based management interface
- [ ] Scheduled security updates
- [ ] Support for multiple storage backends
- [ ] Improved ROM compatibility detection
- [ ] User-friendly settings app

---

## Contributing

Found an issue or want to contribute? Please:
1. Open an issue on [GitHub](https://github.com/OpenBase-Foundation/DumbOS/issues)
2. Send a pull request with improvements
3. Share feedback and use cases

See `README.md` for more information.

---

## License

This project is licensed under the OpenBase Software License (OBSL) v1.0.
See the `LICENSE` file for full details.

---

**Last Updated**: November 11, 2025  
**Repository**: https://github.com/OpenBase-Foundation/DumbOS
