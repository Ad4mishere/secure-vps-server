#!/bin/bash
set -euo pipefail

# =========================
# Configuration
# =========================
BACKUP_ROOT="/backup"
DAILY_DIR="$BACKUP_ROOT/daily"
SNAPSHOT_DATE="$(date +%F)"
SNAPSHOT_DIR="$DAILY_DIR/$SNAPSHOT_DATE"
LATEST_LINK="$BACKUP_ROOT/latest"
RETENTION_DAYS=7

REMOTE_ENABLED=true
REMOTE_USER="backupuser"
REMOTE_HOST="BACKUP_SERVER_IP"
REMOTE_BASE="/backup/vps-server"

# =========================
# Safety checks
# =========================
if [[ $EUID -ne 0 ]]; then
  echo "[!] This script must be run as root"
  exit 1
fi

# =========================
# Prepare directories
# =========================
echo "[*] Creating snapshot directory: $SNAPSHOT_DIR"
mkdir -p "$SNAPSHOT_DIR"

# =========================
# Package inventory
# =========================
echo "[*] Generating package inventory"
dpkg --get-selections > "$SNAPSHOT_DIR/package-list.txt"
chmod 600 "$SNAPSHOT_DIR/package-list.txt"

# =========================
# Core system backup
# =========================
echo "[*] Backing up system data"

rsync -aAX --delete \
  --exclude={"/proc/*","/sys/*","/dev/*","/run/*","/tmp/*","/var/cache/*"} \
  /etc/nginx \
  /home \
  /root \
  /var/www \
  /usr/local \
  "$SNAPSHOT_DIR/"

# =========================
# SSL – self-signed cert only
# =========================
echo "[*] Backing up SSL certificates"
mkdir -p "$SNAPSHOT_DIR/ssl"

if [[ -f /etc/ssl/certs/nginx-selfsigned.crt ]]; then
  rsync -a /etc/ssl/certs/nginx-selfsigned.crt "$SNAPSHOT_DIR/ssl/"
fi

if [[ -f /etc/ssl/private/nginx-selfsigned.key ]]; then
  rsync -a /etc/ssl/private/nginx-selfsigned.key "$SNAPSHOT_DIR/ssl/"
fi

# =========================
# Let's Encrypt (future use)
# =========================
if [[ -d /etc/letsencrypt ]]; then
  echo "[*] Backing up Let's Encrypt data"
  rsync -a /etc/letsencrypt "$SNAPSHOT_DIR/"
fi

# =========================
# Update latest symlink
# =========================
ln -sfn "$SNAPSHOT_DIR" "$LATEST_LINK"

# =========================
# Retention cleanup
# =========================
echo "[*] Applying retention policy ($RETENTION_DAYS days)"
find "$DAILY_DIR" -mindepth 1 -maxdepth 1 -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;

# =========================
# External backup (rsync over SSH)
# =========================
if [[ "$REMOTE_ENABLED" == true ]]; then
  echo "[*] Starting external backup transfer"
  rsync -a --delete \
    "$SNAPSHOT_DIR/" \
    "$REMOTE_USER@$REMOTE_HOST:$REMOTE_BASE/$SNAPSHOT_DATE/"
fi

echo "[+] Backup completed successfully"
