# SSH – REDUCE SERVICE IDENTIFICATION

# Edit SSH configuration
sudo nano /etc/ssh/sshd_config

# Add or ensure the following directives:
# Banner none              -> Disables login banner output
# DebianBanner no          -> Removes Debian/Ubuntu identification
# VersionAddendum none     -> Removes extra version metadata

# Apply changes by restarting SSH
sudo systemctl restart ssh


# FIREWALL HARDENING – DEGRADE OS FINGERPRINTING

sudo iptables -L -n
sudo iptables -I ufw-before-input 1 -p icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT
sudo iptables -A ufw-before-input -p icmp --icmp-type echo-request -j DROP

# MAC ADDRESS SPOOFING – REMOVE VIRTUALIZATION FINGERPRINT

# List available NetworkManager connections
nmcli connection show

# Apply a locally administered MAC address to the active connection
nmcli connection modify "Wired connection 1" ethernet.cloned-mac-address 02:11:22:33:44:55

# Restart the connection to apply the new MAC address
nmcli connection down "Wired connection 1"
nmcli connection up "Wired connection 1"



# NGINX HARDENING – REMOVE SERVER IDENTIFICATION

# Disable version tokens globally
sudo nano /etc/nginx/nginx.conf

# Add inside the http {} block:
# server_tokens off;

# Install nginx build with headers_more module
sudo apt install nginx-extras


# NGINX SITE CONFIGURATION – APPLY HEADER REMOVAL

sudo nano /etc/nginx/sites-enabled/default

# Add inside EACH server {} block:
# more_clear_headers Server;

# Validate configuration
sudo nginx -t

# Reload nginx without downtime
sudo systemctl reload nginx


# VERIFICATION COMMANDS – POST-HARDENING CHECKS

# Verify HTTP headers
curl -I http://localhost

# Verify HTTPS headers
curl -I https://localhost

# Verify MAC address
ip a
