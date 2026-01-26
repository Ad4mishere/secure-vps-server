# Malware Scanner – ClamAV Hardening

This step installs and hardens ClamAV for a production VPS.

The configuration is intentionally conservative and server-safe.

---

## What this does

- Installs ClamAV, clamd, and freshclam
- Applies deterministic configuration from sec-configs
- Updates virus signatures
- Enables background daemon
- Supports manual or scheduled scans

This setup does NOT enable real-time (on-access) scanning.

---

## Why no real-time scanning?

On-access scanning:
- Is resource-heavy
- Causes instability on servers
- Creates false positives
- Is not recommended for general-purpose VPS systems

This design aligns with CIS, Lynis, and industry best practices.

---

## How to run

From the repository root:

```bash
chmod +x scripts/hardening/malware-scanner.sh
sudo ./scripts/hardening/malware-scanner.sh
