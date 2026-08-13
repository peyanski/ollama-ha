# Changelog

## 0.3.6

- **Perf**: Optimized default memory limits for low-RAM hosts (Raspberry Pi/Mini PCs):
  - Set `OLLAMA_CONTEXT_LENGTH=2048` to reduce KV cache memory allocation.
  - Set `OLLAMA_NUM_PARALLEL=1` and `OLLAMA_MAX_LOADED_MODELS=1` to prevent multi-model memory spikes.
- **Docs**: Updated container name references from `addon_` to `app_`.

## 0.3.5

- **Fix**: Resolve build error on amd64/arm64 caused by conflicting symlinks in Alpine base image during binary copy.

## 0.3.4

- **Fix**: Revert base image back to Home Assistant standard (s6-overlay) to fix startup crash.
- **Fix**: Restored app size back to ~165MB (down from 4GB+).
- **Fix**: Dynamic extraction of `llama-server` and libraries from official image.

## 0.3.3

- **Fix**: Use official Ollama image as base to include all runners (llama-server) and GPU libraries.
- Fixes "llama-server binary not found" error for vision/multimodal models.

## 0.3.2

- **Fix**: Include `llama-server` runtime binary and libraries required for vision/multimodal models.
- **Upgrade**: Ollama updated from **v0.32.1** to **v0.32.9**.

## 0.3.1

- **Upgrade**: Ollama updated from **v0.23.0** to **v0.32.1**.

## 0.3.0

- **Upgrade**: Ollama updated from **v0.15.5** to **v0.23.0**.
- Build: Pinned Ollama Docker image to specific version tag for reproducible builds.

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
