# UFW – Firewall Hardening

## Purpose
This script configures a basic firewall using UFW.

Default policy:
- Deny all incoming traffic
- Allow all outgoing traffic

Allowed services:
- OpenSSH
- HTTP (80)
- HTTPS (443)

---

## Prerequisites
- SSH access must be working
- OpenSSH must be allowed before enabling UFW

---

## Run Firewall Hardening

From the repository root:

```bash
chmod +x scripts/hardening/ufw-hardening.sh
sudo ./scripts/hardening/ufw-hardening.sh


# Verify

sudo ufw status verbose
