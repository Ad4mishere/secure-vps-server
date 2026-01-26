# NGINX – LAB HTTPS Hardening (Self-Signed)

## Purpose

This NGINX hardening provides a secure baseline suitable for:
- lab environments
- fresh VPS builds
- testing before production

It intentionally uses a **self-signed TLS certificate** and the default
NGINX site.

This script automatically generates a self-signed TLS certificate if none exists.
Certificates can later be replaced with CA-issued certificates without modifying the script.


No domain name is required.

---

## Design Decisions

- Self-signed TLS (no ACME / Certbot)
- Default site only
- No virtual host abstraction
- No rate limiting
- No WAF
- No application-specific tuning

This ensures:
- immediate functionality
- zero external dependencies
- predictable disaster recovery

---

## What This Hardening Does

- Enables HTTPS with TLS 1.2 / 1.3
- Redirects HTTP → HTTPS
- Disables NGINX version leakage
- Applies standard security headers
- Uses safe SSL parameters
- Reloads NGINX safely after validation

---

## What This Hardening Does NOT Do

- No certificate automation
- No domain configuration
- No HSTS enforcement
- No multi-site configuration

---


## RUN SCRIPT

sudo chmod +x scripts/hardening/nginx-hardening.sh
sudo ./scripts/hardening/nginx-hardening.sh


## Certificate Generation (Required)

Before running the hardening script, generate a self-signed certificate:

```bash
sudo mkdir -p /etc/ssl/private
sudo chmod 700 /etc/ssl/private

sudo openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt
