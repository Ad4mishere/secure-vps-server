#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/auditd/hardening.rules"
CONFIG_DST="/etc/audit/rules.d/hardening.rules"

if [ "$EUID" -ne 0 ]; then
  echo "[!] This script must be run as root"
  exit 1
fi

echo "[*] Ensuring auditd is installed..."

if ! command -v auditctl >/dev/null 2>&1; then
  apt update
  apt install -y auditd audispd-plugins
fi

echo "[*] Applying audit rules..."

cp "$CONFIG_SRC" "$CONFIG_DST"
chown root:root "$CONFIG_DST"
chmod 640 "$CONFIG_DST"

echo "[*] Applying rsyslog rules..."

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/rsyslog/rsyslog.conf"
CONFIG_DST="/etc/rsyslog.conf"

cp "$CONFIG_SRC" "$CONFIG_DST"
chown root:root "$CONFIG_DST"
chmod 644 "$CONFIG_DST"

systemctl restart rsyslog

echo "[*] Loading audit rules..."
augenrules --load

echo "[*] Restarting auditd..."
systemctl restart auditd

echo "[+] Auditd hardening applied successfully."
