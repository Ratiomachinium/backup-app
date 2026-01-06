# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project aims to follow Semantic Versioning.

## [1.0.0] - 2026-01-05

### Added
- `backup-app` CLI supporting `major` and `minor` versioned backups.
- Optional exclusions using `-<path>` markers (must be within the target).
- `list` command to show apps and per-app backups.
- `check` command to list top-level non-hidden directories under a path.
- `help` command and bundled usage documentation (`USAGE.txt`).
- `install.sh` installer for `/usr/local/bin` and `/usr/local/share`.
