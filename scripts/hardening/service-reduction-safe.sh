#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"


SERVICES_TO_DISABLE=(
  cups.service
  cups-browsed.service
  cups.socket
  avahi-daemon.service
  avahi-daemon.socket
  bluetooth.service
  ModemManager.service
  whoopsie.path
  apport.service
  apport-autoreport.path
  apport-autoreport.timer
  apport-forward.socket
  gnome-remote-desktop.service
  switcheroo-control.service
)

OPTIONAL_SERVICES=(
  power-profiles-daemon.service
  wpa_supplicant.service
)

echo "[*] Reducing unnecessary services..."

for svc in "${SERVICES_TO_DISABLE[@]}"; do
  if systemctl list-unit-files | grep -q "^$svc"; then
    echo "[*] Disabling $svc"
    systemctl disable --now "$svc" 2>/dev/null || true
  fi
done

for svc in "${OPTIONAL_SERVICES[@]}"; do
  if systemctl is-active --quiet "$svc"; then
    echo "[*] Disabling optional service $svc"
    systemctl disable --now "$svc" 2>/dev/null || true
  fi
done

echo "[*] Disabling USB storage kernel module..."

CONFIG_SRC="$REPO_ROOT/scripts/sec-configs/modprobe/usb-storage.conf"
CONFIG_DST="/etc/modprobe.d/usb-storage.conf"

cp "$CONFIG_SRC" "$CONFIG_DST"
chown root:root "$CONFIG_DST"
chmod 644 "$CONFIG_DST"




echo "[+] Service reduction complete"
