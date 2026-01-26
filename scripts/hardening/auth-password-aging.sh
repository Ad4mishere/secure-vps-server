#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/auth/login.defs"
CONFIG_DST="/etc/login.defs"

echo "[*] Applying password aging configuration..."

if [ ! -f "$CONFIG_SRC" ]; then
  echo "[!] Password aging config not found: $CONFIG_SRC"
  exit 1
fi

sudo cp "$CONFIG_SRC" "$CONFIG_DST"
sudo chown root:root "$CONFIG_DST"
sudo chmod 644 "$CONFIG_DST"

echo "[+] Password aging configuration applied successfully."
