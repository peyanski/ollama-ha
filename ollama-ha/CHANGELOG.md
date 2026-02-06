# Changelog

## 0.2.4

- Refactor: Renamed "add-on" to "app" across all documentation and descriptions.
- Build: Switched to multi-stage Docker build for robust binary installation.

## 0.2.3

- Feat: Added **icon.png** and **logo.png** for app branding in Home Assistant.

## 0.2.2

- Feat: **Simplified Authentication**.
    - Displays your SSH Public Key in the logs on startup for easy addition to Ollama.com.
    - Added `start_auth` toggle to trigger the sign-in flow and show the code/link in logs.

## 0.2.1

- Fix: Restore documentation visibility in Home Assistant (symlink correction).

## 0.2.0

- Feat: Added **GPU Support** toggle in configuration (disabled by default).
- Polish: Removed unused "models" configuration list.
- Docs: Unified documentation to a single `README.md`.

## 0.1.1

- Fix: Switch to Debian base image to resolve Segmentation Faults on Alpine.
- Fix: Use architecture-specific `build.yaml` to fix `exec format error` on Raspberry Pi/ARM64.
- Feat: Use explicit binary download for robust installation.

## 0.1.0

- Initial release.
