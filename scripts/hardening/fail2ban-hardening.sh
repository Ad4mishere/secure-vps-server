#!/bin/bash
set -e

wait_for_apt() {
  echo "[*] Waiting for apt lock..."
  while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 || \
        sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
    sleep 2
  done
}


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/fail2ban/jail.local"
CONFIG_DST="/etc/fail2ban/jail.local"

echo "[*] Ensuring Fail2Ban is installed..."

if ! command -v fail2ban-client >/dev/null 2>&1; then
  wait_for_apt
  sudo apt update
  sudo apt install -y fail2ban
fi


echo "[*] Applying Fail2Ban configuration..."

if [ ! -f "$CONFIG_SRC" ]; then
  echo "[!] Fail2Ban config not found: $CONFIG_SRC"
  exit 1
fi

sudo cp "$CONFIG_SRC" "$CONFIG_DST"
sudo chown root:root "$CONFIG_DST"
sudo chmod 644 "$CONFIG_DST"

echo "[*] Restarting Fail2Ban..."
sudo systemctl enable fail2ban
sudo systemctl restart fail2ban


echo "[*] Waiting for Fail2Ban socket..."

for i in {1..10}; do
  if [ -S /var/run/fail2ban/fail2ban.sock ]; then
    break
  fi
  sleep 1
done

if [ ! -S /var/run/fail2ban/fail2ban.sock ]; then
  echo "[!] Fail2Ban socket not available after restart"
  exit 1
fi


echo "[*] Verifying Fail2Ban status..."
sudo fail2ban-client status sshd

echo "[+] Fail2Ban hardening applied successfully."
