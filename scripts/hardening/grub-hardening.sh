#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

GRUB_SRC="$REPO_ROOT/scripts/sec-configs/grub/grub"
GRUB_DST="/etc/default/grub"

echo "[*] Applying GRUB hardening..."

# Preconditions
if [ ! -f "$GRUB_SRC" ]; then
  echo "[!] GRUB config not found: $GRUB_SRC"
  exit 1
fi

# Backup once
if [ ! -f /etc/default/grub.bak ]; then
  sudo cp /etc/default/grub /etc/default/grub.bak
fi

# Apply config
sudo cp "$GRUB_SRC" "$GRUB_DST"
sudo chown root:root "$GRUB_DST"
sudo chmod 644 "$GRUB_DST"

# Update grub
sudo update-grub

echo "[+] GRUB hardening applied successfully"
