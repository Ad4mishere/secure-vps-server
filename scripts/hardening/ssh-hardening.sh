#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/ssh/sshd_config"
CONFIG_DST="/etc/ssh/sshd_config"

echo "[*] Ensuring OpenSSH server is installed..."

if ! command -v sshd >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y openssh-server
  sudo systemctl start ssh

fi

echo "[*] Applying SSH hardening..."

# Preconditions
if [ ! -f "$CONFIG_SRC" ]; then
  echo "[!] SSH config not found: $CONFIG_SRC"
  exit 1
fi


# Backup existing config (one-time safety)
if [ ! -f /etc/ssh/sshd_config.bak ]; then
  sudo cp "$CONFIG_DST" /etc/ssh/sshd_config.bak
fi

# Apply config
sudo cp "$CONFIG_SRC" "$CONFIG_DST"
sudo chown root:root "$CONFIG_DST"
sudo chmod 600 "$CONFIG_DST"

# Ensure privilege separation directory exists (MUST be before sshd -t)
if [ ! -d /run/sshd ]; then
  sudo mkdir -p /run/sshd
  sudo chown root:root /run/sshd
  sudo chmod 755 /run/sshd
fi

# Validate SSH configuration
sudo sshd -t



# Reload service safely
sudo systemctl reload ssh

echo "[+] Applying login Banners..."


cp "$REPO_ROOT/scripts/sec-configs/ssh/issue" /etc/issue
cp "$REPO_ROOT/scripts/sec-configs/ssh/issue.net" /etc/issue.net

chown root:root /etc/issue /etc/issue.net
chmod 644 /etc/issue /etc/issue.net


echo "[+] SSH hardening applied successfully"
