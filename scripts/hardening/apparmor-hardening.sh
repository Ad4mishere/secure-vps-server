#!/bin/bash
set -e

echo "[*] Verifying AppArmor status..."

# Check that AppArmor tools exist
if ! command -v aa-status >/dev/null 2>&1; then
  echo "[!] AppArmor tools not found. Is AppArmor installed?"
  exit 1
fi

# Check that AppArmor kernel module is loaded
if ! aa-status >/dev/null 2>&1; then
  echo "[!] AppArmor is not active or not loaded"
  exit 1
fi

echo "[+] AppArmor is active"

# Show summary (non-fatal, informational)
aa-status

echo "[+] AppArmor baseline verification complete"
echo "[i] No profiles were modified by this script"
