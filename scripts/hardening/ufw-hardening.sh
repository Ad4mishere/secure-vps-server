#!/bin/bash
set -e

echo "[*] Applying UFW hardening..."

# Install UFW if missing
if ! command -v ufw >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y ufw
fi

# Reset to clean state
sudo ufw --force reset

# Default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow required services
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

UFW_BEFORE="/etc/ufw/before.rules"

# Inject ICMP hardening if not present
if ! grep -q "ICMP HARDENING – RATE LIMIT" "$UFW_BEFORE"; then
  echo "[*] Adding ICMP fingerprinting hardening..."

  sudo sed -i '/^:ufw-before-input/a \
# ============================================\n\
# ICMP HARDENING – RATE LIMIT ECHO REQUESTS\n\
# ============================================\n\
-A ufw-before-input -p icmp --icmp-type echo-request -m limit --limit 1/second --limit-burst 4 -j ACCEPT\n\
-A ufw-before-input -p icmp --icmp-type echo-request -j DROP\n' "$UFW_BEFORE"

else
  echo "[=] ICMP hardening already present"
fi

# Enable firewall
sudo ufw enable

# Reload to apply before.rules
sudo ufw reload

echo "[+] UFW hardening applied successfully"
