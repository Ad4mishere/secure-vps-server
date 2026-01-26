#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/aide/aide.conf"
CONFIG_DST="/etc/aide/aide.conf"

if [ "$EUID" -ne 0 ]; then
  echo "[!] This script must be run as root"
  exit 1
fi

echo "[*] Ensuring AIDE is installed..."
if ! command -v aide >/dev/null 2>&1; then
  apt update
  apt install -y aide
fi

if [ ! -f "$CONFIG_SRC" ]; then
  echo "[!] AIDE config not found: $CONFIG_SRC"
  exit 1
fi

echo "[*] Applying AIDE configuration..."
cp "$CONFIG_SRC" "$CONFIG_DST"
chown root:root "$CONFIG_DST"
chmod 644 "$CONFIG_DST"

echo "[*] Initializing AIDE database..."
aideinit >/dev/null

echo "[*] Activating baseline database..."
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

echo "[+] AIDE baseline created successfully."
