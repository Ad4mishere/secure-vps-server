#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/sysctl/99-hardening.conf"
CONFIG_DST="/etc/sysctl.d/99-hardening.conf"

if [ "$EUID" -ne 0 ]; then
  echo "[!] This script must be run as root"
  exit 1
fi

echo "[*] Applying kernel sysctl hardening..."

if [ ! -f "$CONFIG_SRC" ]; then
  echo "[!] Sysctl hardening config not found: $CONFIG_SRC"
  exit 1
fi

cp "$CONFIG_SRC" "$CONFIG_DST"
chown root:root "$CONFIG_DST"
chmod 644 "$CONFIG_DST"

echo "[*] Reloading sysctl configuration..."
sysctl --system >/dev/null

echo "[+] Kernel sysctl hardening applied successfully."
