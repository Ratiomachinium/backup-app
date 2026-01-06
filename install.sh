#!/usr/bin/env bash
set -euo pipefail

# Installs backup-app into standard system locations.
# - Script: /usr/local/bin/backup-app
# - Help:   /usr/local/share/backup-app/USAGE.txt

PREFIX_BIN="/usr/local/bin"
PREFIX_SHARE="/usr/local/share/backup-app"

SCRIPT_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin/backup-app"
USAGE_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/share/backup-app/USAGE.txt"

if [[ ! -f "$SCRIPT_SRC" ]]; then
  echo "ERROR: Missing $SCRIPT_SRC" >&2
  exit 1
fi

# Help file is optional, but recommended
HAS_USAGE="no"
if [[ -f "$USAGE_SRC" ]]; then
  HAS_USAGE="yes"
fi

# Require sudo/root for system install
if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "ERROR: This installer must be run with sudo." >&2
  echo "Example: sudo ./install.sh" >&2
  exit 2
fi

install -d "$PREFIX_BIN"
install -m 0755 "$SCRIPT_SRC" "$PREFIX_BIN/backup-app"

if [[ "$HAS_USAGE" == "yes" ]]; then
  install -d "$PREFIX_SHARE"
  install -m 0644 "$USAGE_SRC" "$PREFIX_SHARE/USAGE.txt"
fi

echo "Installed:"
echo "  $PREFIX_BIN/backup-app"
if [[ "$HAS_USAGE" == "yes" ]]; then
  echo "  $PREFIX_SHARE/USAGE.txt"
else
  echo "NOTE: USAGE.txt not installed (missing from repo)."
fi
echo
echo "Try:"
echo "  backup-app help"
