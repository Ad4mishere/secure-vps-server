set -e

echo "[*] Ensuring NGINX is installed..."

if ! command -v nginx >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y nginx nginx-extras
fi


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
NGINX_SRC="$REPO_ROOT/scripts/sec-configs/nginx"

echo "[*] Applying NGINX hardening (LAB baseline)..."


# One-time backups
[ ! -f /etc/nginx/nginx.conf.bak ] && sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
[ ! -f /etc/nginx/sites-available/default.bak ] && sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Ensure destination directories exist
sudo mkdir -p /etc/nginx/snippets

# Apply core configuration
sudo cp "$NGINX_SRC/nginx.conf" /etc/nginx/nginx.conf
sudo cp "$NGINX_SRC/site-default.conf" /etc/nginx/sites-available/default

# Apply security snippets
sudo cp "$NGINX_SRC/security-headers.conf" /etc/nginx/snippets/security-headers.conf
sudo cp "$NGINX_SRC/ssl-params.conf" /etc/nginx/snippets/ssl-params.conf
sudo cp "$NGINX_SRC/self-signed.conf" /etc/nginx/snippets/self-signed.conf

# Permissions
sudo chown root:root \
  /etc/nginx/nginx.conf \
  /etc/nginx/sites-available/default \
  /etc/nginx/snippets/*.conf

sudo chmod 644 \
  /etc/nginx/nginx.conf \
  /etc/nginx/sites-available/default \
  /etc/nginx/snippets/*.conf


CERT="/etc/ssl/certs/nginx-selfsigned.crt"
KEY="/etc/ssl/private/nginx-selfsigned.key"

if [ ! -f "$CERT" ] || [ ! -f "$KEY" ]; then
  echo "[*] Generating self-signed TLS certificate..."

  sudo mkdir -p /etc/ssl/private
  sudo chmod 700 /etc/ssl/private

  sudo openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout "$KEY" \
    -out "$CERT" \
    -subj "/CN=localhost"
fi



# Validate configuration
sudo nginx -t

# Reload service
sudo systemctl reload nginx

echo "[+] NGINX hardening applied successfully"
