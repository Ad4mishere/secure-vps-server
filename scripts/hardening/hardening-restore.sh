#!/bin/bash
set -e

echo "======================================="
echo " Secure VPS – Full Hardening Restore"
echo "======================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run() {
  echo
  echo "[*] Running: $1"
  bash "$SCRIPT_DIR/$1"
}

run "system-update.sh"
run "service-reduction-safe.sh"
run "sysctl-hardening.sh"
run "ufw-hardening.sh"
run "ssh-hardening.sh"
run "auth-password-aging.sh"
run "fail2ban-hardening.sh"
run "auditd-hardening.sh"
run "apparmor-hardening.sh"
run "nginx-hardening.sh"
run "malware-scanner.sh"

echo
echo "[+] Core hardening completed successfully"
echo
echo "[!] Manual steps (by design):"
echo "    - SSH Key Installation"
echo "    - GRUB Installation"
echo "    - AIDE database initialization"
echo "    - TLS certificate creation for web server"
echo
echo "System is now in hardened baseline state."
